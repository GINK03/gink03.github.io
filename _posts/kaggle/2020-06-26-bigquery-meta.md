---
layout: post
title: "bigqueryのメタデータ"
date: 2020-06-26
excerpt: "BigQueryのメタデータについて"
tags: ["bq", "bigquery", "gcp"]
config: true
kaggle: true
comments: false
---

# BigQueryのメタデータについて

## 概要
 - データセットの粒度に対して、テーブルの構造、パーティションの情報、お金に関わる情報などが格納されており、アクセスして確認することができる

## パーティションでまとめられたテーブルを全部リストして確認する

```sql
SELECT
  *
FROM 
  `project.dataset.INFORMATION_SCHEMA.TABLES`
```

## PARTITION_IDの確認

```sql
SELECT 
  *
FROM 
  `project.dataset.INFORMATION_SCHEMA.PARTITIONS`
```

## 参考
 - [INFORMATION_SCHEMA を使用したテーブル メタデータの取得/GCP](https://cloud.google.com/bigquery/docs/information-schema-tables)
 - [INFORMATION_SCHEMA を使用したテーブル メタデータの取得/GCP](https://cloud.google.com/bigquery/docs/information-schema-tables#partitions_view)
 - [INFORMATION_SCHEMAを用いたBigQueryのストレージ無駄遣い調査/zozo](https://techblog.zozo.com/entry/investigating-waste-of-bq-storage)
