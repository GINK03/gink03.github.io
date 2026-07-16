# frozen_string_literal: true

require "addressable/uri"
require "cgi"
require "nokogiri"
require "pathname"
require "set"

site_root = Pathname(ARGV.fetch(0, "_site")).expand_path
site_host = ENV.fetch("SITE_HOST", "gink03.github.io").downcase
html_files = Dir.glob(site_root.join("**/*.html")).map { |path| Pathname(path) }
errors = Set.new
documents = {}
ids = {}

page_url = lambda do |file|
  relative = file.relative_path_from(site_root).to_s
  if relative == "index.html"
    "/"
  elsif relative.end_with?("/index.html")
    "/#{relative.delete_suffix('index.html')}"
  else
    "/#{relative}"
  end
end

document_for = lambda do |file|
  documents[file.to_s] ||= Nokogiri::HTML(File.read(file))
end

target_file = lambda do |path|
  decoded = Addressable::URI.unencode_component(path.to_s)
  trailing_slash = decoded.end_with?("/")
  clean = Pathname("/#{decoded}").cleanpath.to_s.sub(%r{\A/}, "")
  candidates = []
  candidates << site_root.join(clean, "index.html") if trailing_slash || clean.empty?
  candidates << site_root.join(clean)
  if File.extname(clean).empty? && !clean.empty?
    candidates << site_root.join("#{clean}.html")
    candidates << site_root.join(clean, "index.html")
  end
  candidates.find(&:file?)
end

html_files.each do |source_file|
  source_url = page_url.call(source_file)
  base_url = "https://#{site_host}#{source_url}"
  document = document_for.call(source_file)

  document.css("a[href], link[href], script[src], img[src]").each do |element|
    attribute = element["href"] ? "href" : "src"
    raw = CGI.unescapeHTML(element[attribute].to_s.strip)
    next if raw.empty? || raw == "#"
    next if raw.downcase.start_with?("mailto:", "tel:", "javascript:", "data:")

    begin
      uri = Addressable::URI.join(base_url, raw)
    rescue Addressable::URI::InvalidURIError, TypeError
      errors << "#{source_file}: invalid URL #{raw.inspect}"
      next
    end
    next if uri.host && uri.host.downcase != site_host

    target = target_file.call(uri.path)
    unless target
      errors << "#{source_file}: missing #{raw}"
      next
    end
    next if uri.fragment.to_s.empty? || target.extname != ".html"

    fragment = Addressable::URI.unencode_component(uri.fragment)
    target_ids = ids[target.to_s] ||= begin
      target_document = document_for.call(target)
      target_document.xpath("//*[@id or @name]").flat_map { |node| [node["id"], node["name"]] }.compact.to_set
    end
    errors << "#{source_file}: missing fragment #{raw}" unless target_ids.include?(fragment)
  end
end

if errors.any?
  warn "Internal link check failed with #{errors.length} error(s)"
  errors.sort.first(100).each { |error| warn "- #{error}" }
  warn "- ... #{errors.length - 100} more" if errors.length > 100
  exit 1
end

puts "Internal link check passed: #{html_files.length} HTML files"
