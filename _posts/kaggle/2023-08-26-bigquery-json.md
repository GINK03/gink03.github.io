---
layout: post
title: "bigquery json"
date: 2023-08-26
excerpt: "bigqueryのjsonのパースとエンコード"
tags: ["bq", "bigquery", "gcp", "bigquery", "json"]
kaggle: true
comments: false
sort_key: "2023-08-26"
update_dates: ["2023-08-26"]
---

# bigqueryのjsonのパースとエンコード

## 概要
 - 偶にBigQueryのデータにjsonエンコードされたテキストが入っていることがあり、パースする必要がある
   - 要素にアクセスして、値とみなすには `JSON_EXTRACT_SCALAR` 関数を用いる

## パースの例

```sql
SELECT
  JSON_EXTRACT_SCALAR(raw_json, '$.name') as name,
  JSON_EXTRACT_SCALAR(raw_json, '$.email') as email
FROM UNNEST([
  '{"name": "山田 太郎", "email": "taro.yamada@example.com"}',
  '{"name": "佐藤 花子", "email": "hanako.sato@example.com"}',
  '{"name": "鈴木 一郎", "email": "ichiro.suzuki@example.com"}',
  '{"name": "田中 二郎", "email": "jiro.tanaka@example.com"}',
  '{"name": "高橋 三郎", "email": "saburo.takahashi@example.com"}'
]) as raw_json
```

| name      | email                        |
|-----------|------------------------------|
| 山田 太郎 | taro.yamada@example.com      |
| 佐藤 花子 | hanako.sato@example.com      |
| 鈴木 一郎 | ichiro.suzuki@example.com    |
| 田中 二郎 | jiro.tanaka@example.com      |
| 高橋 三郎 | saburo.takahashi@example.com |

## 参考
 - [JSON functions/Google Cloud](https://cloud.google.com/bigquery/docs/reference/standard-sql/json_functions)
