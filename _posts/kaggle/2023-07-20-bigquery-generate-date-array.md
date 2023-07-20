---
layout: post
title: "bigquery generate date array(日付の生成)"
date: 2023-07-20
excerpt: "bigqueryのgenerate date array(日付の生成)の使い方"
tags: ["bq", "bigquery", "gcp", "bigquery", "generate date array"]
kaggle: true
comments: false
sort_key: "2023-07-20"
update_dates: ["2023-07-20"]
---

# bigqueryのgenerate date array(日付の生成)の使い方

## 概要
 - BigQueryにおけるpandasのdate_rangeに相当する機能
 - 特定のテーブルのsuffixにデータをスキャンする場合のスキャンコスト削減や、無駄にPARTITIONのメタ情報をスキャンしなくても良くなるなどのメリットが有る 

## 具体例

```sql
SELECT 
  FORMAT_DATE("%Y-%m-%d", DATE_SUB(day, INTERVAL 1 DAY)) as each_last_day
FROM
  UNNEST(GENERATE_DATE_ARRAY("2020-01-01", "2099-01-01", INTERVAL 1 MONTH)) as day
```

| each_last_day |
|--------------:|
|    2019-12-31 |
|    2020-01-31 |
|    2020-02-29 |
|    2020-03-31 |
|    2020-04-30 |
|    2020-05-31 |
|    2020-06-30 |
|    2020-07-31 |
|    2020-08-31 |
|    2020-09-30 |
|    2020-10-31 |
|    2020-11-30 |
|    2020-12-31 |

## 参考
 - [GENERATE_DATE_ARRAY/google.cloud.com](https://cloud.google.com/bigquery/docs/reference/standard-sql/array_functions#generate_date_array)
