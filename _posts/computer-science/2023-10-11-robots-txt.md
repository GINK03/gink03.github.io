---
layout: post
title: "robots.txt"
date: 2023-10-09
excerpt: "robots.txtについて"
computer_science: true
tag: ["robots.txt", "SEO", "検索エンジン"]
comments: false
sort_key: "2023-10-09"
update_dates: ["2023-10-09"]
---

# robots.txtについて

## 概要
 - 検索エンジンのクローラーがサイトをクロールする際に参照するファイル
 - ルートディレクトリにおいて使用する
   - e.g. `https://example.com/robots.txt`
 - クローラーのユーザエージェントによって参照させるディレクトリを変えることができる
 - `robots.txt`はお願いベースのプロトコルであるため、クローラーが`robots.txt`に従うかどうかはクローラー次第
 - 近年ではAIに学習されたくないという意思表示をするために使用されることがある

## 設定例

```txt
# Googlebotに対する設定
User-agent: Googlebot
Disallow: /private/
Allow: /private/public/

# Bingのクローラーに対する設定
User-agent: Bingbot
Disallow: /private/
Disallow: /archive/

# GPTBot(openai)のクローラーに対する設定
User-agent: GPTBot
Disallow: /private/
Disallow: /archive/

# すべてのクローラーに対するデフォルトの設定
User-agent: *
Disallow: /tmp/
```

## 参考になる設定

```console
$ curl -s https://gigazine.net/robots.txt | less
```

## 参考
 - [GPTBot](https://platform.openai.com/docs/gptbot)
