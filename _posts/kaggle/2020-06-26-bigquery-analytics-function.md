---
layout: post
title: "bigquery analytics function(分析関数)"
date: 2020-06-26
excerpt: "bigquery analytics function(分析関数)について"
tags: ["bq", "bigquery", "gcp", "analytics function", "window function", "分析関数"]
kaggle: true
comments: false
sort_key: "2022-03-29"
update_dates: ["2022-03-29"]
---

# bigquery analytics function(分析関数)について

## 概要
 - bigqueryなどで使えるanalytics function(分析関数)の説明
   - analytics functionには別名が多くあり、window functionと表現されることもあった
   - bigqueryのWebUIでanalytics functionと表現されているため、analytics functionとして扱う
 - 分析関数はアナリティクス関数やウィンドウ関数とも呼ばれる
 - row番号を取得したい、lagを計算したいなどができる
 - 分析関数は集計関数とは異なり、行ごとに値を返す
   - 単純にGROUP BYしてしまうとリークになる場合にも利用できる
 - `WHERE`, `HAVING`ではフィルタできず、`QUALIFY`という機能で記述する必要がある

## 基本構文

```sql
関数名() OVER (
  [PARTITION BY 列名]
  [ORDER BY 列名 [ASC|DESC]]
  [ウィンドウフレーム]
)
```
 - `PARTITION BY`: グルーピングする列を指定
 - `ORDER BY`: ソートする列を指定
 - `ウィンドウフレーム`: ウィンドウフレームを指定

## 各種機能

### RANK()関数
 - 概要
   - ランキングをつけることができる
 - 具体例
   - 様々なカテゴリの商品で最も値段が高いものを一つ選びたい

```sql
SELECT
   item,
   category,
   RANK() OVER (PARTITION BY category ORDER BY purchases DESC) as rank
FROM  
  UNNEST([
    STRUCT('kale' as item, 23 as purchases, 'vegetable' as category),
    ('banana', 2, 'fruit'),
    ('cabbage', 9, 'vegetable'),
    ('apple', 8, 'fruit'),
    ('leek', 2, 'vegetable'),
    ('lettuce', 10, 'vegetable')
  ])
QUALIFY rank <= 1

"""
行	item  category  rank
1	  apple fruit     1
2	  kale  vegetable 1
"""
```

### ROW_NUMBER()関数
 - 概要
   - row番号を付与する
   - 特定のキーでグルーピング可能
 - 具体例
   - 何度も同じidが出現するテーブルで時系列で新しいレコードを取得したい
   - グループごとにTOP Nを取得したい

```sql
SELECT 
  *,
  -- idでパーティション分割し、updated_atの時系列で降順に並び替え
  ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) as row_number
FROM 
  `project.bucket.table`
QUALIFY
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

---

## 参考
 - [How to use the Qualify Function in BigQuery SQL](https://medium.com/codex/how-to-use-the-qualify-function-in-bigquery-sql-e0979cabb9a6)
