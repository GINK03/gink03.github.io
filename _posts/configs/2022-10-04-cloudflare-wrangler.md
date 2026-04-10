---
layout: post
title: "cloudflare wrangler"
date: 2022-10-04
excerpt: "cloudflare wranglerの使い方"
tag: ["cloudflare", "wrangler"]
config: true
comments: false
sort_key: "2022-10-04"
update_dates: ["2022-10-04"]
---

# cloudflare wranglerの使い方

## 概要
 - GCPのgcloud, AWSのawsコマンドに相当するツール
 - npmでインストールできる

## インストール

```console
$ npm install -g wrangler / bun install -g wrangler
```

## 認証
 - URLが表示されるのでブラウザでアクセスして認証
 - ブラウザ上のURLを別タブのターミナルに貼り付けCURLコマンドを実行する

```console
$ wrangler login
$ curl "http://localhost:8976/oauth/callback?code=xxxxxx&scope=xxxxxx&state=xxxxxx" # 別タブのターミナルで実行
```
