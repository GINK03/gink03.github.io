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
$ bundle exec jekyll build --strict_front_matter
$ bundle exec ruby scripts/verify_generated_site.rb _site
$ bundle exec ruby scripts/check_internal_links.rb _site
```

短文記事やメタデータの監査結果を更新する場合は次を実行する

```console
$ bundle exec ruby scripts/generate_content_audit.rb
```

## 公開

`master` へのpush後にGitHub Pagesがビルドとデプロイを実行する

```console
$ gh run list --limit 5
```
