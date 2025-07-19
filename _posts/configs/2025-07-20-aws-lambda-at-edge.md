---
layout: post
title: "awscli lambda@edge"
date: 2025-07-20
excerpt: "awscli lambda@edgeの使い方"
tags: ["aws", "lambda@edge", "cloudfront"]
config: true
comments: false
sort_key: "2025-07-20"
update_dates: ["2025-07-20"]
---

# awscli lambda@edgeの使い方

## 概要
 - lambda@edgeはCloudFrontのエッジロケーションで実行されるlambda関数
 - `us-east-1`でlambda関数を作成して、CloudFrontのディストリビューションに関連付ける必要がある

## 代表的なユースケース
 - カスタム認証
   - JWT や Cookie を検証し、失効時 302/401 返却
 - 国際化リダイレクト
   - Accept‑Language と GeoIP を見て `/en/` `/jp/` に振り分け
 - シンプル SPA ルーティング
   - 404 時に `/index.html` を返す―Viewer Request でパス書き換え
 - 画像フォーマット変換
   - Origin Request で `Accept: image/avif` を判定し、S3 上オブジェクト名を書き換え
 - A/B テスト
   - Cookie 付与＋パス分岐で配信割合を制御

## 参考リンク
 - [Lambda@Edge 概要と活用](https://chatgpt.com/share/687c157d-c678-8012-a1b0-08734e45cb67)
