# frozen_string_literal: true

require "json"
require "nokogiri"
require "pathname"
require "set"
require_relative "content_helpers"

site_root = Pathname(ARGV.fetch(0, "_site")).expand_path
errors = []
html_files = Dir.glob(site_root.join("**/*.html"))
article_count = 0
mathjax_count = 0

html_files.each do |path|
  document = Nokogiri::HTML(File.read(path))
  next unless document.at_css('meta[property="og:type"][content="article"]')

  article_count += 1

  h1_count = document.css("article h1").length
  errors << "#{path}: expected one article h1, got #{h1_count}" unless h1_count == 1

  image_url = document.at_css('meta[property="og:image"]')&.[]("content").to_s
  unless image_url.start_with?("https://")
    errors << "#{path}: og:image must use HTTPS"
  end

  json_ld = document.css('script[type="application/ld+json"]')
  if json_ld.length != 1
    errors << "#{path}: expected one JSON-LD block, got #{json_ld.length}"
  else
    begin
      data = JSON.parse(json_ld.first.text)
      errors << "#{path}: JSON-LD type must be BlogPosting" unless data["@type"] == "BlogPosting"
      errors << "#{path}: JSON-LD dateModified is required" if data["dateModified"].to_s.empty?
    rescue JSON::ParserError => error
      errors << "#{path}: invalid JSON-LD #{error.message}"
    end
  end

  related_urls = document.css("section.related-posts li a").map { |link| link["href"] }
  errors << "#{path}: more than five related posts" if related_urls.length > 5
  errors << "#{path}: duplicate related posts" if related_urls.uniq.length != related_urls.length

  mathjax_count += 1 if document.at_css('script[src*="MathJax.js"]')
end

expected_articles = ContentHelpers.load_posts.length
unless article_count == expected_articles
  errors << "expected #{expected_articles} article pages, got #{article_count}"
end
if mathjax_count.zero? || mathjax_count >= article_count
  errors << "MathJax must load only on pages with math content"
end

{
  "tags/index.html" => 450_000,
  "posts/index.html" => 450_000
}.each do |relative_path, maximum_bytes|
  path = site_root.join(relative_path)
  if !path.file?
    errors << "missing generated page #{relative_path}"
  elsif path.size > maximum_bytes
    errors << "#{relative_path}: #{path.size} bytes exceeds #{maximum_bytes}"
  end
end

tags_path = site_root.join("tags/index.html")
if tags_path.file?
  tags_document = Nokogiri::HTML(File.read(tags_path))
  tag_ids = tags_document.css("h2.tag-heading[id]").map { |heading| heading["id"] }
  errors << "tag page contains duplicate heading IDs" if tag_ids.uniq.length != tag_ids.length
end

sitemap_path = site_root.join("sitemap.xml")
if sitemap_path.file?
  sitemap = Nokogiri::XML(File.read(sitemap_path))
  sitemap.remove_namespaces!
  sitemap.xpath("//loc").each do |location|
    if location.text.match?(%r{/(?:AGENTS|docs|scripts)(?:/|$)})
      errors << "sitemap exposes operational path #{location.text}"
    end
  end
else
  errors << "missing sitemap.xml"
end

["AGENTS/index.html", "docs", "scripts"].each do |relative_path|
  errors << "generated site exposes #{relative_path}" if site_root.join(relative_path).exist?
end

if errors.any?
  warn "Generated site verification failed with #{errors.length} error(s)"
  errors.first(100).each { |error| warn "- #{error}" }
  exit 1
end

puts "Generated site verification passed: #{article_count} articles, #{mathjax_count} MathJax pages"
