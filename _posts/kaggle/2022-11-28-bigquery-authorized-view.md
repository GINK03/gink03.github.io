---
layout: post
title: "bigquery authorized view"
date: 2022-11-28
excerpt: "bigquery authorized viewの概要と使い方"
tags: ["bq", "bigquery", "gcp", "authorized view", "認証済みビュー"]
kaggle: true
comments: false
sort_key: "2022-11-28"
update_dates: ["2022-11-28"]
---

# bigquery authorized viewの使い方

## 概要
 - 権限を設定できるビュー
 - ユースケース
   - あるプロジェクトにあるテーブルを別のプロジェクトにビューだけ作る
     - 権限的に、別のプロジェクトの内部で完結できる
   - アナリストに見せたいデータの範囲を限定する

## 具体的な認証済みビューの作成
 - 権限を持つ管理者が共有したいプロジェクトでクエリを作成
 - クエリをビューとして保存
 - 以下オプション
   - `[共有データセット]`を開く
   - `[プリンシパルを追加]`を開き、`example@example.com(google groupなど)`を追加
   - `[ロールを選択]`から、`[BigQuery] > [BigQuery データ閲覧者] `を設定
   - `[追加]`をクリック

---

## 参考
 - [承認済みビューを作成する/GoogleCloud](https://cloud.google.com/bigquery/docs/share-access-views)
