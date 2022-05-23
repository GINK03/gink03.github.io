---
layout: post
title: "bigqueryのpartition"
date: 2020-06-26
excerpt: "BigQueryのpartitionについて"
tags: ["bq", "bigquery", "gcp"]
kaggle: true
comments: false
---

# BigQueryのpatitionについて

## 概要
 - partitionを分割することでクエリ時にスキャンする範囲を限定し、金銭的な負荷を減らす
 - partitionには日時や値などを取ることができる
 - partition情報は普段は隠された情報として格納されている
   - e.g.
     - `__partitiontime`
     - `_PARTITIONTIME`
     - `_PARTITIONDATE`

## パーティションを指定してクエリを実行する
 - 例えば、`_PARTITIONTIME`で分割されているとき

```sql
SELECT
  *
FROM
  `project.dataset.table`
WHERE
  DATE(_PARTITIONTIME) = "2099-01-01";
```

## 最新のパーティションを動的に特定してクエリを実行する
 - 例えば、`_PARTITIONTIME`で分割されているとき

```sql
SELECT 
  *
FROM 
  `project.dataset.table`
WHERE 
  __PARTITIONTIME in (SELECT MAX(__PARTITIONTIME) FROM `project.dataset.table`)
```

## 参考
 - [パーティション分割テーブルに対するクエリ/GCP](https://cloud.google.com/bigquery/docs/querying-partitioned-tables)
