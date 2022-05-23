---
layout: post
title: "bigquery public data"
date: 2020-06-26
excerpt: "bigquery public dataについて"
tags: ["bq", "bigquery", "gcp", "dataset", "データセット"]
kaggle: true
comments: false
sort_key: "2022-04-13"
update_dates: ["2022-04-13","2022-04-05","2022-04-04"]
---

# bigquery public dataについて

## 概要
 - bigqueryで利用できる公開データセット
 - カラムに対する詳細な説明は[マーケットプレイス](https://console.cloud.google.com/marketplace/product/bigquery-public-datasets/)から確認できる
 - [リンク](https://console.cloud.google.com/bigquery?p=bigquery-public-data)

## データセット各種

### `bigquery-public-data:google_trends`
 - [ドキュメント](https://console.cloud.google.com/marketplace/product/bigquery-public-datasets/google-search-trends)
 - 日付別、地域別のGoogle検索のトレンド情報
   - Google検索のトレンドの単語はiPhone -> Appleなど丸められるようだ
 - 地域の粒度は都道府県
 - 日付の粒度は週(refresh_dateまで考慮すれば日)

#### サンプルクエリ

**最新のトレンドを確認**  
```sql
WITH tmp AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY term, refresh_date ORDER BY week DESC) as row_number
    FROM `bigquery-public-data.google_trends.international_top_terms`
    WHERE country_code = "JP" AND region_name LIKE "%Tokyo%"
)
SELECT 
    *
FROM tmp
WHERE row_number = 1
ORDER BY refresh_date, rank
```

#### サンプル集計(Google Colab)
 - [google-trend-example](https://colab.research.google.com/drive/1QBZIz5wzaRTtPb-v3mD9SrUdaZeud-R7?usp=sharing)
