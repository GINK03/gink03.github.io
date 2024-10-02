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
 - 使い方はpandasのpivot_tableと似ている(bigqueryのpivotは集計関数を指定する必要がある)
 - 制限
   - 基本的にコード上でカラムにしたい値がわかっている前提の運用が期待されている
   - カラムを動的に指定したい場合、`EXECUTE IMMEDIATE`で記述する必要がある

## 具体例

```sql
WITH Produce AS (
  SELECT 'Kale' as product, 51 as sales, 'Q1' as quarter, 2020 as year UNION ALL
  SELECT 'Kale', 23, 'Q2', 2020 UNION ALL
  SELECT 'Kale', 45, 'Q3', 2020 UNION ALL
  SELECT 'Kale', 3, 'Q4', 2020 UNION ALL
  SELECT 'Kale', 70, 'Q1', 2021 UNION ALL
  SELECT 'Kale', 85, 'Q2', 2021 UNION ALL
  SELECT 'Apple', 77, 'Q1', 2020 UNION ALL
  SELECT 'Apple', 0, 'Q2', 2020 UNION ALL
  SELECT 'Apple', 1, 'Q1', 2021
/*---------+------+----+------+------+------*
 | product | year | Q1 | Q2   | Q3   | Q4   |
 +---------+------+----+------+------+------+
 | Apple   | 2020 | 77 | 0    | NULL | NULL |
 | Apple   | 2021 | 1  | NULL | NULL | NULL |
 | Kale    | 2020 | 51 | 23   | 45   | 3    |
 | Kale    | 2021 | 70 | 85   | NULL | NULL |
 *---------+------+----+------+------+------*/  
)

SELECT
  * 
FROM
  Produce
PIVOT(
  SUM(sales) FOR quarter IN ('Q1', 'Q2', 'Q3', 'Q4')
)
/*---------+-----+-----+------+------*
 | product | Q1  | Q2  | Q3   | Q4   |
 +---------+-----+-----+------+------+
 | Apple   | 78  | 0   | NULL | NULL |
 | Kale    | 121 | 108 | 45   | 3    |
 *---------+-----+-----+------+------*/
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
