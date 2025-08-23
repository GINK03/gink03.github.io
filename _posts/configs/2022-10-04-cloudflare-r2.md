---
layout: post
title: "Cloudflare R2"
date: 2022-10-04
excerpt: "Cloudflare R2の使い方"
tag: ["cloudflare", "r2", "s3互換"]
config: true
comments: false
sort_key: "2022-10-04"
update_dates: ["2022-10-04"]
---

# Cloudflare R2の使い方

## 概要
 - Cloudflare が提供する S3 互換のオブジェクトストレージ
 - **エグレス料金無料**: 世界中のエッジに配置されるので、エグレス料金が無料
   - ストレージ料金は B2 のほうが安いが、egress が安くないので、公開用の画像をホストする目的で R2 を使用するのがよい
 - **ドメイン連携**: ドメインサービスで取得したドメインのサブドメイン等に R2 を紐づけることができる
   - 静的なサイトであれば、これ単体でホスティングが完結する
 - **Free Tier**: 10GB まで無料


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
   - 公開用の URL でアクセスする
   - `https://<public-url>/<filename>`

## アクセス設定
 - Cyberduck などのクライアントでアクセスする場合
   - R2 の S3 API 用のアクセスキーを作成する（Access Key ID と Secret Access Key）
   - アカウント ID と作成したアクセスキーを用いて接続する
     - エンドポイント例: `https://<account-id>.r2.cloudflarestorage.com`
