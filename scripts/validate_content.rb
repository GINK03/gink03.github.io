# frozen_string_literal: true

require "date"
require "jekyll/utils"
require_relative "content_helpers"

errors = []
posts = ContentHelpers.load_posts

valid_date = lambda do |value|
  next false unless value.match?(/\A\d{4}-\d{2}-\d{2}\z/)

  Date.iso8601(value)
  true
rescue Date::Error
  false
end

posts.each do |post|
  data = post.data
  errors << "#{post.path}: title is required" if post.title.strip.empty?
  errors << "#{post.path}: excerpt is required" if post.excerpt.strip.empty?
  errors << "#{post.path}: at least one tag is required" if post.tags.empty?
  errors << "#{post.path}: duplicate tags" if post.tags.uniq.length != post.tags.length

  published_date = ContentHelpers.iso_date(data["date"])
  errors << "#{post.path}: date must use a valid YYYY-MM-DD value" unless valid_date.call(published_date)

  update_dates = Array(data["update_dates"]).map { |date| ContentHelpers.iso_date(date) }
  if data.key?("update_dates") && update_dates.empty?
    errors << "#{post.path}: remove empty update_dates"
  end
  update_dates.each do |date|
    errors << "#{post.path}: invalid update_dates value #{date.inspect}" unless valid_date.call(date)
  end
  if update_dates != update_dates.uniq.sort.reverse
    errors << "#{post.path}: update_dates must be unique and sorted newest first"
  end

  sort_key = data["sort_key"].to_s
  if sort_key.empty?
    errors << "#{post.path}: sort_key is required"
  elsif !valid_date.call(sort_key)
    errors << "#{post.path}: sort_key must use a valid YYYY-MM-DD value"
  else
    expected_sort_key = ([published_date] + update_dates).select { |date| valid_date.call(date) }.max
    if expected_sort_key && sort_key != expected_sort_key
      errors << "#{post.path}: sort_key must match latest date #{expected_sort_key}"
    end
  end

  errors.concat(ContentHelpers.heading_violations(post))
end

posts.group_by(&:url).each do |url, matches|
  next if matches.length == 1

  errors << "duplicate permalink #{url}: #{matches.map(&:path).join(', ')}"
end

tag_variants = Hash.new { |hash, key| hash[key] = [] }
tag_counts = Hash.new(0)
posts.each do |post|
  post.tags.each do |tag|
    tag_variants[tag.downcase] << tag
    tag_counts[tag] += 1
  end
end
tag_variants.each do |folded, values|
  variants = values.uniq.sort
  next if variants.length == 1
  next if folded == "map" && variants == ["MAP", "map"]

  errors << "tag case variants for #{folded}: #{variants.join(', ')}"
end

tag_slugs = Hash.new { |hash, key| hash[key] = [] }
tag_counts.each do |tag, count|
  next if count < 3

  slug = Jekyll::Utils.slugify(tag.downcase, mode: "raw")
  tag_slugs[slug] << tag
end
tag_slugs.each do |slug, tags|
  errors << "tag anchor collision for #{slug}: #{tags.sort.join(', ')}" if tags.length > 1
end

if errors.any?
  warn "Content validation failed with #{errors.length} error(s)"
  errors.each { |error| warn "- #{error}" }
  exit 1
end

short_posts = posts.count { |post| post.body_characters < 500 }
same_excerpt = posts.count { |post| post.title.strip.casecmp?(post.excerpt.strip) }
no_internal_links = posts.count { |post| post.internal_links.empty? }
singleton_tags = tag_variants.count { |_, values| values.length == 1 }

puts "Content validation passed: #{posts.length} posts"
puts "Audit counters: short_under_500=#{short_posts} excerpt_equals_title=#{same_excerpt} no_internal_links=#{no_internal_links} singleton_tags=#{singleton_tags}"
