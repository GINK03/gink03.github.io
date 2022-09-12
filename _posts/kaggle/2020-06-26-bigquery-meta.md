---
layout: post
title: "bigqueryのメタデータ"
date: 2020-06-26
excerpt: "BigQueryのメタデータについて"
tags: ["bq", "bigquery", "gcp", "meta"]
kaggle: true
comments: false
sort_key: "2022-05-11"
update_dates: ["2022-05-11"]
---

# BigQueryのメタデータについて

## 概要
 - データセットの粒度に対して、テーブルの構造、パーティションの情報、お金に関わる情報などが格納されており、アクセスして確認することができる
 - テーブル名のサフィックスにもアクセスすることができ、最新のテーブルだけに限定してクエリを実行するなどができる

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

## tableの最新のサフィックスに限定してクエリを実行する

```sql
SELECT
  *
FROM
  `project.dataset.table_*`
WHERE
  _TABLE_SUFFIX in (SELECT MAX(_TABLE_SUFFIX) FROM `project.dataset.table_*`)
```
 - 一見すると、すべての行にアクセスするように見えるが、最新のテーブルサフィックスを計算するイディオムとして利用できる

---

## 参考
 - [INFORMATION_SCHEMA を使用したテーブル メタデータの取得/GCP](https://cloud.google.com/bigquery/docs/information-schema-tables)
 - [INFORMATION_SCHEMA を使用したテーブル メタデータの取得/GCP](https://cloud.google.com/bigquery/docs/information-schema-tables#partitions_view)
 - [INFORMATION_SCHEMAを用いたBigQueryのストレージ無駄遣い調査/zozo](https://techblog.zozo.com/entry/investigating-waste-of-bq-storage)
 - [ワイルドカード テーブルを使用した複数テーブルに対するクエリ/GCP](https://cloud.google.com/bigquery/docs/querying-wildcard-tables?hl=ja)
