# frozen_string_literal: true

require "fileutils"
require_relative "content_helpers"

output_path = "docs/active/content-consolidation.md"
posts = ContentHelpers.load_posts
short_posts = posts.select { |post| post.body_characters < 200 }.sort_by do |post|
  [post.body_characters, post.path]
end
draft_posts = posts.select { |post| post.path.include?("/_posts/blog-drafts/") || post.path.include?("_posts/blog-drafts/") }
duplicate_excerpts = posts.select { |post| post.title.strip.casecmp?(post.excerpt.strip) }.sort_by(&:path)

display = lambda do |value|
  value.to_s.gsub("|", "\\|").delete("\u3002")
end
link = lambda do |post|
  relative = post.path.sub(%r{\A\./}, "")
  "[#{relative}](../../#{relative})"
end

lines = []
lines << "# 短文記事とメタデータの統合監査"
lines << ""
lines << "> **Status**: Active"
lines << ""
lines << "記事の削除や非公開化を自動判断せず、統合候補を確認するための一覧"
lines << ""
lines << "## 集計"
lines << ""
lines << "| 指標 | 件数 |"
lines << "|---|---:|"
lines << "| 全記事 | #{posts.length} |"
lines << "| 本文500文字未満 | #{posts.count { |post| post.body_characters < 500 }} |"
lines << "| 本文1000文字未満 | #{posts.count { |post| post.body_characters < 1000 }} |"
lines << "| 本文内の内部リンクなし | #{posts.count { |post| post.internal_links.empty? }} |"
lines << "| 概要がタイトルと同一 | #{duplicate_excerpts.length} |"
lines << "| `_posts/blog-drafts/` 配下 | #{draft_posts.length} |"
lines << ""
lines << "本文文字数はfrontmatterを除き、空白を削除した文字数"
lines << ""
lines << "## 本文200文字未満"
lines << ""
lines << "| 文字数 | 記事 | タイトル | 判定 |"
lines << "|---:|---|---|---|"
short_posts.each do |post|
  lines << "| #{post.body_characters} | #{link.call(post)} | #{display.call(post.title)} | 未判定 |"
end
lines << ""
lines << "## 公開中のblog-drafts"
lines << ""
lines << "`_posts/blog-drafts/` はJekyllでは通常記事として公開される"
lines << ""
lines << "| 文字数 | 記事 | タイトル | 判定 |"
lines << "|---:|---|---|---|"
draft_posts.sort_by(&:path).each do |post|
  lines << "| #{post.body_characters} | #{link.call(post)} | #{display.call(post.title)} | 未判定 |"
end
lines << ""
lines << "## 概要がタイトルと同一"
lines << ""
lines << "| 記事 | タイトル |"
lines << "|---|---|"
duplicate_excerpts.each do |post|
  lines << "| #{link.call(post)} | #{display.call(post.title)} |"
end
lines << ""

generated = lines.join("\n")
if ARGV.include?("--check")
  current = File.exist?(output_path) ? File.read(output_path) : ""
  if current != generated
    warn "Content audit is stale: run bundle exec ruby scripts/generate_content_audit.rb"
    exit 1
  end
  puts "Content audit is current"
else
  FileUtils.mkdir_p(File.dirname(output_path))
  File.write(output_path, generated)
  puts "Wrote #{output_path}"
end
