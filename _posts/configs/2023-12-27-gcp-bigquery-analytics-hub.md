---
layout: post
title: "gcp bigquery analytics hub"
date: 2023-12-27
excerpt: "gcp bigquery analytics hubの概要"
tag: ["gcp", "bigquery", "analytics hub", "terraform"]
config: true
comments: false
sort_key: "2023-12-27"
update_dates: ["2023-12-27"]
---

# gcp bigquery analytics hub

## 概要
 - BigQueryのデータセットをプロジェクト・組織をまたいで共有するための機能
 - データの公開単位はデータセットになる

## 権限管理の観点でのユースケース
 - データレイク側のプロジェクトでPIIを除去・マスクしたデータセットをAnalytics Hubで公開することで、アナリスト向けプロジェクトにread onlyのデータセットを安全に共有できる
   - アナリストにデータレイク本体へのアクセス権を付与する必要がなくなる
   - 公開データセットの購読者はread onlyのため、元データへの書き込みや削除のリスクを排除できる
 - エクスチェンジ単位で権限を管理するため、データセットごとに個別に権限設定する手間が省ける
 - 管理にはTerraformを用いるのが一般的で、`google_bigquery_analytics_hub_data_exchange` および `google_bigquery_analytics_hub_listing` リソースで構成管理できる

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

