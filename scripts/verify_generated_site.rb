# frozen_string_literal: true

require "json"
require "nokogiri"
require "pathname"
require "set"
require "uri"
require_relative "content_helpers"

site_root = Pathname(ARGV.fetch(0, "_site")).expand_path
errors = []
html_files = Dir.glob(site_root.join("**/*.html"))
article_count = 0
article_urls = Set.new
mathjax_count = 0
image_count = 0
missing_image_alt = 0
missing_image_dimensions = 0

normalize_path = lambda do |url|
  URI::DEFAULT_PARSER.unescape(URI(url).path)
rescue URI::InvalidURIError
  url
end

related_data = JSON.parse(File.read("_data/related_posts.json"))
expected_related = related_data.fetch("related").to_h do |page_url, related_urls|
  [
    normalize_path.call(page_url),
    related_urls.map { |related_url| normalize_path.call(related_url) }
  ]
end

html_files.each do |path|
  document = Nokogiri::HTML(File.read(path))
  errors << "#{path}: html lang must be ja" unless document.at_css("html")&.[]("lang") == "ja"
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

  canonical_url = document.at_css('link[rel="canonical"]')&.[]("href").to_s
  unless canonical_url.start_with?("https://gink03.github.io/")
    errors << "#{path}: canonical URL must use the public HTTPS origin"
  end
  article_urls << canonical_url
  social_share_urls = document.css("span.social-share a[href]").map { |link| link["href"] }
  if social_share_urls.empty? || social_share_urls.any? { |url| !url.include?(canonical_url) }
    errors << "#{path}: social share URLs must include the canonical URL"
  end
  page_url = normalize_path.call(canonical_url)
  related_urls = document.css("section.related-posts li a").map { |link| link["href"] }
  related_paths = related_urls.map { |url| normalize_path.call(url) }
  errors << "#{path}: more than five related posts" if related_urls.length > 5
  errors << "#{path}: duplicate related posts" if related_urls.uniq.length != related_urls.length
  errors << "#{path}: related posts include the current article" if related_paths.include?(page_url)
  unless related_paths == expected_related.fetch(page_url, [])
    errors << "#{path}: rendered related posts do not match generated data"
  end

  mathjax_scripts = document.css('script[src*="MathJax"], script[src*="mathjax"]')
  mathjax_count += 1 if mathjax_scripts.any?
  errors << "#{path}: multiple MathJax scripts" if mathjax_scripts.length > 1

  article_images = document.css("article.content img")
  image_count += article_images.length
  article_images.each_with_index do |image, index|
    missing_image_alt += 1 if image["alt"].to_s.strip.empty?
    if image["width"].to_s.empty? || image["height"].to_s.empty?
      missing_image_dimensions += 1
    end
    errors << "#{path}: article image must use async decoding" unless image["decoding"] == "async"
    if index.positive? && image["loading"] != "lazy"
      errors << "#{path}: article images after the first must use lazy loading"
    end
  end

  has_disqus_thread = document.at_css("#disqus_thread")
  if !has_disqus_thread && document.to_html.include?("disqus.com")
    errors << "#{path}: Disqus loaded without an enabled comment thread"
  end
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
  sitemap_urls = sitemap.xpath("//loc").map(&:text)
  errors << "sitemap contains duplicate URLs" if sitemap_urls.uniq.length != sitemap_urls.length
  missing_articles = article_urls - sitemap_urls.to_set
  unless missing_articles.empty?
    errors << "sitemap is missing #{missing_articles.length} article URL(s)"
  end
  sitemap_urls.each do |location|
    if location.match?(%r{/(?:AGENTS|docs|scripts)(?:/|$)})
      errors << "sitemap exposes operational path #{location}"
    end
  end
else
  errors << "missing sitemap.xml"
end

robots_path = site_root.join("robots.txt")
if !robots_path.file?
  errors << "missing robots.txt"
elsif !File.read(robots_path).include?("Sitemap: https://gink03.github.io/sitemap.xml")
  errors << "robots.txt must declare the public sitemap"
end

not_found_path = site_root.join("404.html")
if !not_found_path.file?
  errors << "missing 404.html"
else
  not_found = Nokogiri::HTML(File.read(not_found_path))
  robots = not_found.at_css('meta[name="robots"]')&.[]("content").to_s
  errors << "404.html must use noindex" unless robots.split(",").map(&:strip).include?("noindex")
end

["AGENTS/index.html", "docs", "scripts"].each do |relative_path|
  errors << "generated site exposes #{relative_path}" if site_root.join(relative_path).exist?
end

if errors.any?
  warn "Generated site verification failed with #{errors.length} error(s)"
  errors.first(100).each { |error| warn "- #{error}" }
  exit 1
end

puts "Generated site verification passed: #{article_count} articles, #{mathjax_count} MathJax pages, #{image_count} images"
puts "Image audit: missing_alt=#{missing_image_alt} missing_dimensions=#{missing_image_dimensions}"
