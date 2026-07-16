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
missing_alt_posts = posts.select { |post| post.missing_alt_images.any? }.sort_by(&:path)
filename_date_mismatches = posts.select do |post|
  post.filename_date && post.filename_date != ContentHelpers.iso_date(post.data["date"])
end.sort_by(&:path)
external_http_links = posts.flat_map do |post|
  post.external_http_links.map { |url| [url, post] }
end.sort_by { |url, post| [url, post.path] }

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
lines << "| 記事内画像 | #{posts.sum { |post| post.images.length }} |"
lines << "| altが空の画像 | #{posts.sum { |post| post.missing_alt_images.length }} |"
lines << "| HTTP外部リンク | #{external_http_links.map(&:first).uniq.length} |"
lines << "| ファイル名と公開日の不一致 | #{filename_date_mismatches.length} |"
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
lines << "## altが空の画像"
lines << ""
lines << "alt文言は画像の内容を確認して記述する必要があるため自動補完しない"
lines << ""
lines << "| 記事 | 件数 | タイトル |"
lines << "|---|---:|---|"
missing_alt_posts.each do |post|
  lines << "| #{link.call(post)} | #{post.missing_alt_images.length} | #{display.call(post.title)} |"
end
lines << ""
lines << "## HTTP外部リンク"
lines << ""
lines << "HTTPS対応とリンク先の生存確認後に修正する"
lines << ""
lines << "| URL | 記事 |"
lines << "|---|---|"
external_http_links.each do |url, post|
  lines << "| `#{display.call(url)}` | #{link.call(post)} |"
end
lines << ""
lines << "## ファイル名と公開日の不一致"
lines << ""
lines << "パーマリンクはタイトル由来のため、ファイル名変更だけでは公開URLは変わらない"
lines << ""
lines << "| ファイル名の日付 | 公開日 | 記事 |"
lines << "|---|---|---|"
filename_date_mismatches.each do |post|
  lines << "| #{post.filename_date} | #{ContentHelpers.iso_date(post.data["date"])} | #{link.call(post)} |"
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
