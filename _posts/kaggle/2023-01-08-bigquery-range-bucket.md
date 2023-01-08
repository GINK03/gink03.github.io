---
layout: post
title: "bigquery range bucket"
date: 2023-01-08
excerpt: "bigquery range bucketの概要と使い方"
tags: ["bq", "bigquery", "gcp", "range_bucket", "range bucket"]
kaggle: true
comments: false
sort_key: "2023-01-08"
update_dates: ["2023-01-08"]
---

# bigquery range bucketの使い方

## 概要
 - アレイで与えた配列の上限のインデックスを返す
 - ユースケース
   - 年齢の情報をビニングして年代に変換するなど

## 具体例

```sql
SELECT
  user_id,
  age,
  RANGE_BUCKET(age, [0, 10, 20, 30, 40, 50, 60, 70, 80]) * 10 - 10 as nendai
FROM UNNEST([
  STRUCT(1 AS user_id, 5 AS age),
  (2, 35),
  (3, 21),
  (4, 51),
  (5, 85)
])
```

**出力**
```csv
user_id,age,nendai
1,5,0
2,35,30
3,21,20
4,51,50
5,85,80
```

---

## 参考
 - [RANGE_BUCKET/GoogleCloud](https://cloud.google.com/bigquery/docs/reference/standard-sql/mathematical_functions#range_bucket)
 - [RANGE_BUCKET function in Bigquery - SQL Syntax and Examples](https://roboquery.com/app/syntax-range-bucket-function-bigquery)
