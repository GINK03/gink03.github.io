---
layout: post
title: "bigquery string"
date: 2020-06-26
excerpt: "bigquery stringのチートシート"
tags: ["bq", "bigquery", "gcp"]
kaggle: true
comments: false
sort_key: "2022-09-09"
update_dates: ["2022-09-09"]
---

# bigquery stringのチートシート

## LOWER

```sql
(SELECT
  'FOO' as item
UNION ALL
SELECT
  'BAR' as item
UNION ALL
SELECT
  'BAZ' as item)

SELECT
  LOWER(item) AS example
FROM items;

+---------+
| example |
+---------+
| foo     |
| bar     |
| baz     |
+---------+
```

## CONCAT

```sql
SELECT CONCAT('T.P.', ' ', 'Bar') as author;

+---------------------+
| author              |
+---------------------+
| T.P. Bar            |
+---------------------+
```

---

## 参考
 - [文字列関数/Google Cloud](https://cloud.google.com/bigquery/docs/reference/standard-sql/string_functions?hl=ja)
