# gink03.github.io

Jekyllで構築した技術ブログのMarkdownとテンプレートを管理するリポジトリ

公開サイト: [https://gink03.github.io/](https://gink03.github.io/)

## 必要な環境

 - Ruby 3.3.4
 - Bundler
 - gitleaks

## セットアップ

```console
$ bundle install
```

## ローカル表示

```console
$ bundle exec jekyll serve --livereload
```

`http://127.0.0.1:4000/` で確認できる

## 品質チェック

```console
$ bundle exec ruby scripts/validate_content.rb
$ bundle exec ruby scripts/generate_content_audit.rb --check
$ bundle exec ruby scripts/generate_related_posts.rb --check
$ bundle exec jekyll build --strict_front_matter
$ bundle exec ruby scripts/enhance_article_images.rb _site
$ bundle exec ruby scripts/verify_generated_site.rb _site
$ bundle exec ruby scripts/check_internal_links.rb _site
$ gitleaks dir . --redact
$ gitleaks git . --redact
```

記事、タグ、タイトル、日付を変更した場合は生成データを更新する

```console
$ bundle exec ruby scripts/generate_content_audit.rb
$ bundle exec ruby scripts/generate_related_posts.rb
```

外部リンクは毎週月曜日に`.github/workflows/external-links.yml`で検査され、結果はGitHub Job Summaryへ出力される

## 公開

content quality Workflowが検証済みの`_site`をGitHub Pagesへデプロイする

Workflowを初めて反映した後はPagesの公開方式を一度だけ切り替える

```console
$ gh api --method PUT repos/GINK03/gink03.github.io/pages -f build_type=workflow
```

`master`へのpush後はビルドとデプロイ結果を確認する

```console
$ gh run list --limit 5
```
