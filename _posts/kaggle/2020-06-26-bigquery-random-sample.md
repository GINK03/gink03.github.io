---
layout: post
title: "bigquery random sample"
date: 2020-06-26
excerpt: "bigquery random sampleの方法"
tags: ["bq", "bigquery", "gcp", "SQL"]
kaggle: true
comments: false
sort_key: "2022-03-01"
update_dates: []
---

# bigquery random sampleの方法

## 指定行数をランダムサンプルする

```sql
SELECT  
    *
FROM `project_id.bucket_name.table_name`
ORDER BY RAND()
LIMIT 500000
```

## カテゴリごとに指定行数をランダムサンプルする
 - window関数を使用して、ランダムなindexを割り振る
 - indexの大きさでしきい値を決定する

```sql
SELECT
  *
FROM 
  (
    SELECT
      *,
      ROW_NUMBER() OVER (PARTITION BY <category-name> ORDER BY RAND()) AS th_index
    FROM
      `project_id.bucket_name.table_name` 
  )
WHERE
  th_index <= 10000
```

## 再現性を担保しつつサンプルする
 - ハッシュ関数(`FARM_FINGERPRINT`)を利用して数値を作成し、MODを取る

```sql
WITH t AS (
  SELECT
    word,
    ROW_NUMBER() OVER() AS rn
  FROM
    `publicdata.samples.shakespeare`
)
SELECT
  word
FROM
  t
WHERE
  MOD(ABS(FARM_FINGERPRINT(CAST(rn AS STRING))), 1600) = 0
```

## bigqueryのプレビュー機能を用いたサンプリング
 - [テーブルのサンプリング](https://cloud.google.com/bigquery/docs/table-sampling)

## 参考
 - [TOP N PER GROUP IN BIGQUERY](https://dankleiman.com/2017/10/30/top-n-per-group-in-bigquery/)
