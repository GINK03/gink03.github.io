---
layout: post
title: "bigquery safe cast"
date: 2025-02-15
excerpt: "bigquery safe cast"
tags: ["bq", "bigquery", "gcp", "bigquery", "cast"]
kaggle: true
comments: false
sort_key: "2025-02-15"
update_dates: ["2025-02-15"]
---

# bigquery safe cast

## 概要
 - bigqueryでのcastを安全に行う方法
 - 例外が発生するような場合にはnullを返す

## 例

**２行目がnullになる**
```sql
SELECT
  col_str,
  SAFE_CAST(col_str AS INT64)         AS cast_to_int,
  SAFE_CAST(col_float_str AS FLOAT64)   AS cast_to_float,
  SAFE_CAST(col_bool AS BOOL)           AS cast_to_bool,
  SAFE_CAST(col_date AS DATE)           AS cast_to_date,
  SAFE_CAST(col_datetime AS DATETIME)   AS cast_to_datetime,
  SAFE_CAST(col_datetime AS TIMESTAMP)  AS cast_to_timestamp,
  SAFE_CAST(col_numeric_str AS NUMERIC) AS cast_to_numeric
FROM UNNEST([
  STRUCT(
    "123"             AS col_str,
    "123.456"         AS col_float_str,
    "true"            AS col_bool,
    "2025-02-15"      AS col_date,
    "2025-02-15 12:34:56" AS col_datetime,
    "456.789"         AS col_numeric_str
  ),
  STRUCT(
    "abc"             AS col_str,
    "not_a_float"     AS col_float_str,
    "not_bool"        AS col_bool,
    "invalid_date"    AS col_date,
    "invalid_datetime" AS col_datetime,
    "not_numeric"     AS col_numeric_str
  )
]);
```
