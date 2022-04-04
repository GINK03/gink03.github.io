---
layout: post
title: "bigquery public data"
date: 2020-06-26
excerpt: "bigquery public dataについて"
tags: ["bq", "bigquery", "gcp", "dataset", "データセット"]
config: true
kaggle: true
comments: false
---

# bigquery public dataについて

## 概要
 - bigqueryで利用できる公開データセット
 - [リンク](https://console.cloud.google.com/bigquery?p=bigquery-public-data)

## データセット各種

### `bigquery-public-data:google_trends`
 - 日付別、地域別のGoogle検索のトレンド情報
   - Google検索のトレンドの単語はiPhone -> Appleなど丸められるようだ
 - 地域の粒度は都道府県
 - 日付の粒度は週(refresh_dateまで考慮すれば日)

#### サンプルクエリ

**最新のトレンドを確認**  
```sql
WITH max_week AS (
    SELECT
        max(week) as max_week
    FROM `bigquery-public-data.google_trends.international_top_terms`
    WHERE country_code = "JP"
)
SELECT 
    *
FROM `bigquery-public-data.google_trends.international_top_terms`
INNER JOIN max_week 
ON week = max_week.max_week
WHERE country_code = "JP" AND region_name LIKE "%Tokyo%"
ORDER BY refresh_date, region_name, rank
```

#### サンプル集計(Google Colab)
 - [google-trend-example](https://colab.research.google.com/drive/1QBZIz5wzaRTtPb-v3mD9SrUdaZeud-R7?usp=sharing)
