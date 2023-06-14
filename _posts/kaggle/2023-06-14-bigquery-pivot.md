---
layout: post
title: "bigquery pivot"
date: 2023-06-14
excerpt: "bigqueryのpivotの使い方"
tags: ["bq", "bigquery", "gcp", "bigquery", "pivot"]
kaggle: true
comments: false
sort_key: "2023-06-14"
update_dates: ["2023-06-14"]
---

# bigqueryのpivotの使い方

## 概要
 - `PIVOT`を記述することで特定のvalueをカラムに変換できる
   - 基本的にコード上でカラムにしたい値がわかっている前提の運用が期待されている
   - カラムを動的に指定したい場合、`EXECUTE IMMEDIATE`で記述する必要がある

## 具体例

```sql
SELECT
  *
FROM
(
  SELECT 
    airline,
    departure_airport,
    departure_delay
  FROM 
    `bigquery-samples.airline_ontime_data.flights`
)
PIVOT 
(
  AVG(departure_delay) AS mean_delay 
  FOR airline in ('AA', 'KH', 'DL', '9E')
)
```

## 動的にカラムを設定する例

```sql
DECLARE columns STRING;
SET columns = (
  SELECT 
    CONCAT('("', STRING_AGG(DISTINCT airline, '", "'), '")'),
  FROM `bigquery-samples.airline_ontime_data.flights`
);

EXECUTE IMMEDIATE format("""
SELECT * FROM
(
  SELECT 
    airline,
    departure_airport,
    departure_delay
  FROM `bigquery-samples.airline_ontime_data.flights`
)
PIVOT
(
  AVG(departure_delay) AS avgdelay
  FOR airline in %s
)
ORDER BY departure_airport ASC
""", columns);
```

## 参考
 - [PIVOT in BigQuery](https://towardsdatascience.com/pivot-in-bigquery-4eefde28b3be)
