---
layout: post
title: "gcp bigquery analytics hub"
date: 2023-12-27
excerpt: "gcp bigquery analytics hubの概要"
tags: ["gcp", "bigquery", "analytics hub"]
config: true
comments: false
sort_key: "2023-12-27"
update_dates: ["2023-12-27"]
---

# gcp bigquery analytics hub

## 概要
 - BigQueryのデータセットをプロジェクト・組織をまたいで共有するための機能
 - データの公開単位はデータセットになる

## 権限の粒度と設定
 - プリンシパル
   - Googleアカウント
   - Googleグループ
   - サービスアカウント
   - G Suiteドメイン

## 基本的な用語
 - publisher
   - データセット公開する側
 - subscriber
   - データセットを購読する側
 - リスティング
   - 公開されたデータセットの一覧の単位
 - エクスチェンジ
   - リスティングを複数まとめて管理する単位
   - プリンシパルで権限を付与する単位

## データセットの公開
 - 公開側のプロジェクトでエクスチェンジを作成
 - エクスチェンジに公開したいデータセットをリスティングとして追加
 - エクスチェンジに対してsubscriberの権限を付与

## データセットの購読
 - 購読側のプロジェクトでエクスチェンジ画面を表示
 - `🔍エクスチェンジを検索` から購読したいエクスチェンジを検索
 - `+データセットをプロジェクトに追加` から購読したいデータセットを選択

## 参考
 - [Analytics Hub の概要 | Google Cloud](https://cloud.google.com/bigquery/docs/analytics-hub-introduction?hl=ja)
 - [Analytics Hubを使ってプロジェクト間でデータのやり取りを簡単にする](https://zenn.dev/d2c_mtech_blog/articles/e8c9fed7231b2a)

