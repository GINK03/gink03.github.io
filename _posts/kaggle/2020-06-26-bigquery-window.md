---
layout: post
title: "bigquery window関数(分析関数)"
date: 2020-06-26
excerpt: "bigquery window関数(分析関数)について"
tags: ["bq", "bigquery", "gcp", "window function", "分析関数"]
kaggle: true
comments: false
sort_key: "2022-03-29"
update_dates: ["2022-03-29"]
---

# bigquery window関数について

## 概要
 - bigqueryなどで使えるwindow関数(分析関数)の説明
 - row番号を取得したい、lagを計算したいなどができる
 - 単純にGROUP BYしてしまうとリークになる場合にも利用できる

## 各種機能

### ROW_NUMBER()関数
 - 概要
   - row番号を付与する
   - 特定のキーでグルーピング可能
 - 具体例
   - 何度も同じidが出現するテーブルで時系列で新しいレコードを取得したい

```sql
SELECT
  *
FROM
    ( 
        SELECT 
        *,
        -- idでパーティション分割し、updated_atの時系列で降順に並び替え
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) as row_number
        FROM `project.bucket.table`
    )
WHERE 
    row_number = 1
```

### 今までのデータの要約値を計算する
 - 概要
   - GROUP BYすると将来のデータまでを参照するので、リークになってしまうようなケースに使用する
   - `AVG`, `MAX`, `MIN`, `COUNT`, `SUM`など利用できる
 - 具体例
   - 何度も同じidが出現するテーブルで累積の要約値を得る

```sql
SELECT 
  *,
  -- idでパーティション分割し、updated_atの時系列で昇順に並び替え
  AVG(score) OVER (PARTITION BY id ORDER BY updated_at) as cumulative_mean_score,
  COUNT(*) OVER (PARTITION BY id ORDER BY updated_at) as cumulative_count_num,
  SUM(score) OVER (PARTITION BY id ORDER BY updated_at) as cumulative_score,
FROM 
  `project.bucket.table`
```
