# frozen_string_literal: true

require "date"
require "fileutils"
require "json"
require_relative "content_helpers"

OUTPUT_PATH = "_data/related_posts.json"
RELATED_LIMIT = 5

posts = ContentHelpers.load_posts
posts_by_path = posts.to_h { |post| [post.path, post] }
post_index = posts.to_h do |post|
  [
    post.url,
    {
      "title" => post.title,
      "date" => ContentHelpers.iso_date(post.data["date"])
    }
  ]
end
tag_index = Hash.new { |hash, key| hash[key] = [] }
posts.each do |post|
  post.tags.uniq.each { |tag| tag_index[tag] << post.path }
end

post_metrics = posts.to_h do |post|
  [
    post.path,
    {
      date: Date.iso8601(ContentHelpers.iso_date(post.data["date"])),
      section: File.dirname(post.path),
      short: post.body_characters < 500
    }
  ]
end

related_posts = posts.to_h do |post|
  post_metric = post_metrics.fetch(post.path)
  scores = Hash.new(0)
  post.tags.uniq.each do |tag|
    tag_index[tag].each do |candidate_path|
      next if candidate_path == post.path

      scores[candidate_path] += 1
    end
  end

  ranked_paths = scores.keys.min_by(RELATED_LIMIT) do |candidate_path|
    candidate_metric = post_metrics.fetch(candidate_path)
    [
      -scores.fetch(candidate_path),
      candidate_metric.fetch(:short) ? 1 : 0,
      candidate_metric.fetch(:section) == post_metric.fetch(:section) ? 0 : 1,
      (candidate_metric.fetch(:date) - post_metric.fetch(:date)).abs,
      candidate_path
    ]
  end

  [post.url, ranked_paths.map { |candidate_path| posts_by_path.fetch(candidate_path).url }]
end

data = {
  "posts" => post_index,
  "related" => related_posts
}
generated = "#{JSON.pretty_generate(data)}\n"
if ARGV.include?("--check")
  current = File.exist?(OUTPUT_PATH) ? File.read(OUTPUT_PATH) : ""
  if current != generated
    warn "Related posts are stale: run bundle exec ruby scripts/generate_related_posts.rb"
    exit 1
  end
  puts "Related posts are current: #{related_posts.length} articles"
else
  FileUtils.mkdir_p(File.dirname(OUTPUT_PATH))
  File.write(OUTPUT_PATH, generated)
  puts "Wrote #{OUTPUT_PATH} for #{related_posts.length} articles"
end
