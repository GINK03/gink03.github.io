---
layout: post
title: "bigquery window関数"
date: 2020-06-26
excerpt: "bigquery window関数について"
tags: ["bq", "bigquery", "gcp"]
config: true
kaggle: true
comments: false
---

# bigquery window関数について

## 概要
 - bigqueryなどで使えるwindow関数(分析関数)の説明
 - row番号を取得したい、lagを計算したいなどができる


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
