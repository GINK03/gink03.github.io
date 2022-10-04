---
layout: post
title: "cloudflare r2"
date: 2022-10-04
excerpt: "cloudflare r2の使い方"
tags: ["cloudflare", "r2", "s3互換"]
config: true
comments: false
sort_key: "2022-10-04"
update_dates: ["2022-10-04"]
---

# cloudflare r2の使い方

## 概要
 - cloudflareが提供するs3互換のサービス
 - 世界中のエッジに配置されるので、エグレス料金が安い
   - ストレージ料金はbackblazeのほうが安いらしいが、egressが安くないので、公開用の画像をホストする目的でR2を使用するのがいい
 - 10Gまでなら無料で使える
 - インターネットに公開ができるので画像等をホストするサーバとして想定可能

## 基本的な操作

**バケットを作成する**
```console
$ wrangler r2 bucket create <my-bucket>
```

**バケットの一覧を確認**
```console
$ wrangler r2 bucket list
[
  {
    "name": "my-bucket",
    "creation_date": "2022-10-03T02:04:12.467Z"
  }
]
```

## 公開アクセスを有効にする
 - 手順
   - `R2` -> バケットを選択 -> `設定` -> `公開アクセス`を許可
 - アクセス
   - 公開後に発行されるURLでのアクセスになる
   - `https://<public-url>/<filename>`
