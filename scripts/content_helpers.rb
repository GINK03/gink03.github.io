# frozen_string_literal: true

require "date"
require "addressable/uri"
require "jekyll/url"
require "jekyll/utils"
require "kramdown"
require "kramdown-parser-gfm"
require "nokogiri"
require "yaml"

module ContentHelpers
  FRONT_MATTER = /\A---\s*\n(.*?)\n---\s*\n/m

  Post = Struct.new(:path, :data, :body, keyword_init: true) do
    def tags
      Array(data["tags"] || data["tag"]).map(&:to_s)
    end

    def title
      data["title"].to_s
    end

    def excerpt
      data["excerpt"].to_s
    end

    def body_characters
      body.gsub(/\s+/, "").length
    end

    def rendered_body
      @rendered_body ||= Nokogiri::HTML.fragment(
        Kramdown::Document.new(body, input: "GFM").to_html
      )
    end

    def links
      rendered_body.css("a[href]").map { |link| link["href"] }
    end

    def internal_links
      links.select do |href|
        href.start_with?("/") || href.start_with?("https://gink03.github.io/")
      end
    end

    def external_http_links
      links.select do |href|
        href.start_with?("http://") &&
          !href.start_with?("http://localhost") &&
          !href.start_with?("http://127.0.0.1") &&
          !href.start_with?("http://gink03.github.io")
      end
    end

    def images
      rendered_body.css("img")
    end

    def missing_alt_images
      images.select { |image| image["alt"].to_s.strip.empty? }
    end

    def filename_date
      File.basename(path).match(/\A(\d{4}-\d{2}-\d{2})-/)&.[](1)
    end

    def url
      return data["permalink"].to_s if data["permalink"]

      title = File.basename(path, ".md").sub(/\A\d{4}-\d{2}-\d{2}-/, "")
      slug = Jekyll::Utils.slugify(title, mode: "pretty", cased: true)
      "/#{Jekyll::URL.escape_path(slug)}/"
    end
  end

  module_function

  def load_posts(root = ".")
    Dir.glob(File.join(root, "_posts/**/*.md")).sort.map do |path|
      text = File.read(path)
      match = text.match(FRONT_MATTER)
      raise "front matter not found: #{path}" unless match

      data = YAML.safe_load(match[1], permitted_classes: [Date, Time], aliases: true) || {}
      Post.new(path: path, data: data, body: text[match.end(0)..] || "")
    rescue Psych::SyntaxError => error
      raise "invalid front matter: #{path}: #{error.message}"
    end
  end

  def iso_date(value)
    return value.strftime("%Y-%m-%d") if value.respond_to?(:strftime)

    value.to_s[0, 10]
  end

  def heading_violations(post)
    violations = []
    previous_level = nil
    fence = nil

    post.body.each_line.with_index(1) do |line, line_number|
      if (match = line.match(/^\s*(```|~~~)/))
        marker = match[1]
        fence = fence == marker ? nil : marker if fence.nil? || fence == marker
        next
      end
      next if fence || line.match?(/^( {4}|\t)/)

      match = line.match(/^([#]{1,6})\s+/)
      next unless match

      level = match[1].length
      violations << "#{post.path}:#{line_number}: body h1 is not allowed" if level == 1
      if previous_level && level > previous_level + 1
        violations << "#{post.path}:#{line_number}: heading jumps from h#{previous_level} to h#{level}"
      end
      previous_level = level
    end

    violations
  end
end
