# frozen_string_literal: true

require "nokogiri"
require "pathname"

site_root = Pathname(ARGV.fetch(0, "_site")).expand_path
abort "Generated site not found: #{site_root}" unless site_root.directory?

article_count = 0
image_count = 0
changed_files = 0

Dir.glob(site_root.join("**/*.html")).sort.each do |path|
  html = File.read(path)
  document = Nokogiri::HTML(html)
  next unless document.at_css('meta[property="og:type"][content="article"]')

  article = document.at_css("article.content")
  next unless article

  article_count += 1
  changed = false
  article.css("img").each_with_index do |image, index|
    image_count += 1
    if image["decoding"] != "async"
      image["decoding"] = "async"
      changed = true
    end
    next unless index.positive? && image["loading"] != "lazy"

    image["loading"] = "lazy"
    changed = true
  end
  next unless changed

  File.write(path, document.to_html)
  changed_files += 1
end

puts "Enhanced #{image_count} images across #{changed_files} of #{article_count} article pages"
