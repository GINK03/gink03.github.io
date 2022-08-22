---
layout: post
title: "google ads" 
date: "2022-07-26"
excerpt: "google adsの概要と使い方"
config: true
tag: ["google ads"]
comments: false
sort_key: "2022-07-26"
update_dates: ["2022-07-26"]
---

# google adsの概要と使い方

## 概要
 - google adwardsの次のサービス
 - `Dispaly`, `Video`, `App`, `Smart`キャンペーンなど


## App Campaigns(アプリ キャンペーン)について
 - 概要
   - Google検索、Google Play、YouTube、Googleディスプレイネットワークの全てにリーチできる
   - アプリの有料会員を増やすためのキャンペーン
   - 広告文、画像や動画などのアセット、入札単価を設定
 - 粒度
   - `キャンペーン` -> `広告グループ(AdGroup)` -> `アセット(Asset)`
 - アセット同士の最適化について
   - 自動で組み合わせの試行錯誤が行われ、最適なパフォーマンスになる
 - アセットのパフォーマンスについて
   - `App Campaigns` -> `Assets`でレポートを標示・ダウンロードできる
 - 参考
   - [アプリ キャンペーンについて](https://support.google.com/google-ads/answer/6247380?hl=ja)

## APIでのアクセス
 - 用語
   - 開発者トークン
     - 会社で一つのみ発行可能
   - (GoogleCloudプロジェクトの)クライアントID
     - クライアントIDを開発者トークンにバインドして利用する
 - APIの利用開始
   - Google Adsでの手続き
     - MMCアカウントで、Google Ads APIの利用依頼
     - MMCアカウントで、`開発者トークン`の発行
   - GCPでの手続き
     - GCPでOAuthを発行
     - 自分のアカウントでログインし、許可し、`refresh_token`を取得
   - 申請時に必要な書類
     - APIを申請した場合のアプリの仕様書
       - 誰が利用し、どんな頻度でAPIにアクセスするのかを明示した資料が必要
 - 実際のプログラムでGoogle Adsにアクセス
   - OAuthの`client_id`, `client_secret`, `refresh_token`と、Google Adsの`開発者トークン`が必要
 - APIの申請でよくある問題
   - すでに他のGoogle Adsのアカウントに紐付いており、ポリシー的にできなくなっている
     - 多くの場合、管理者が退職していたりなどで不在になり、Googleにアドホックな対応をして貰う必要がある
 - APIでアクセスできない場合の代替手段
   - パフォーマンスレポートをgoogle sheetに書き出すことができる
 - 参考
   - [クイックスタート/Google Ads API](https://developers.google.com/google-ads/api/docs/first-call/overview)
   - [クライアント ライブラリ/Google Ads API](https://developers.google.com/google-ads/api/docs/client-libs)
   - [Getting started with the Google Ads API using Python](https://www.cahoover.com/blog/marketing-analytics/getting-started-with-the-google-ads-api-using-python/)

## パフォーマンスレポート
 - CTRやCVRやImpressionなど一般的な指標
   - 特徴
     - Google Sheetにパフォーマンスを定期的に書き出すことができる
 - 投稿掲載日や変更など特殊なデータ
   - 特徴
     - `Change History`から参照できる
     - 定期実行ができない
