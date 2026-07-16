# frozen_string_literal: true

require "date"
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

    def internal_links
      body.scan(/(?<!!)\[[^\]]*\]\(([^)]+)\)/).flatten.select do |href|
        href.start_with?("/") || href.start_with?("https://gink03.github.io/")
      end
    end

    def url
      return data["permalink"].to_s if data["permalink"]

      slug = File.basename(path, ".md").sub(/\A\d{4}-\d{2}-\d{2}-/, "")
      "/#{slug}/"
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
