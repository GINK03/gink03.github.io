---
layout: post
title: "bigquery permissions"
date: 2023-08-20
excerpt: "bigqueryの権限関連について"
tags: ["bq", "bigquery", "gcp", "bigquery", "permissions"]
kaggle: true
comments: false
sort_key: "2023-07-20"
update_dates: ["2023-07-20"]
---

# bigqueryの権限関連について

## 概要
 - 分析を行うに当たってBigQueryの実行権限・アクセス権限に悩まされることが多い
   - 特に、BigQueryがアクセスしている元データがGCSやGoogle Sheetsなどから来ていると別途そのアクセス権限が必要になる
 - ユースケース毎の適応例
   - 特定のユーザに特定のデータセットだけを閲覧可能にしたい
     - `roles/bigquery.jobUser`をプロジェクト全体に対して設定した上で、`roles/bigquery.dataViewer`を特定のデータセットに限定して適応する

## クエリの実行権限
 - `roles/bigquery.jobUser`

## プロジェクト単位での権限
 - `roles/bigquery.dataViewer`
 - `roles/bigquery.dataEditor`
 - `roles/bigquery.dataOwner`

## データセット単位での権限
 - `roles/bigquery.dataViewer`
 - `roles/bigquery.dataEditor`
 - `roles/bigquery.dataOwner`

**権限の付与**
```sql
GRANT `roles/bigquery.dataViewer`
ON SCHEMA mydataset
TO 'user:joe@example.com';
```

**権限の取消**
```sql
REVOKE `roles/bigquery.dataViewer`
ON SCHEMA mydataset
FROM 'user:joe@example.com';
```

## GCSから読み込んでいる場合
 - Storage object viewerの権限が別途必要になる

## 参考
 - [IAM の概要/cloud.google.com/bigquery](https://cloud.google.com/bigquery/docs/access-control?hl=ja)
 - [BigQueryのアクセス制御と権限設計を解説](https://blog.g-gen.co.jp/entry/bigquery-iam-permission)
 - [Query table in Google BigQuery has error "Access Denied: BigQuery BigQuery: Permission denied while globbing file pattern."](https://stackoverflow.com/questions/64276972/query-table-in-google-bigquery-has-error-access-denied-bigquery-bigquery-perm)
