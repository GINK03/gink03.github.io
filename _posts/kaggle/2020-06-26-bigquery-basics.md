---
layout: post
title: "bigqueryb basics"
date: 2020-06-26
excerpt: "bigqueryの基本"
tags: ["bq", "bigquery", "gcp"]
kaggle: true
comments: false
sort_key: "2022-03-01"
update_dates: ["2022-03-01"]
---

# bigqueryの基本

## COUNT(DISTINCT value)
 - group byしたときにユニーク数を出す

```sql
SELECT 
  key,
  COUNT(DISTINCT value) AS unuque_num
FROM `table`
GROUP BY key
```

## ANY_VALUE関数
 - group byしたときに一つだけ要素を取り出す

```sql
SELECT 
  key,
  ANY_VALUE(value) AS a_value
FROM `table`
GROUP BY key
```

## BETWEEN演算子
 - 日時の指定のときに便利
 - 境界条件が `x <= column <= y`であり、境界を含む

```sql
SELECT
  *
FROM
  `table`
WHERE
  date BETWEEN "yyyy-mm-dd" AND "YYYY-MM-DD"
```
