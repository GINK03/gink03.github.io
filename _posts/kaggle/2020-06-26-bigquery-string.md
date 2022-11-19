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

## REGEXP_EXTRACT, REGEXP_EXTRACT_ALL
 - 正規表現で一致した内容をパースする
 - `REGEXP_EXTRACT_ALL`はすべてパースする(nestしたレコードになるので、最終的にUNNESTの操作が必要)

**具体例**
```sql
SELECT
  id,
  name,
  email,
  REGEXP_EXTRACT(email, r"^([a-zA-Z0-9]{1,})@") as email_prefix, -- emailのプレフィックスにマッチする
FROM UNNEST([
  STRUCT("abc" AS name, "abc@google.com" as email, 1 AS id),
  ("abcd", "abc@microsoft.com", 2),
  ("例子", "reiko@google.com", 4),
  ("例夫", "reio@yahoo.com", 10),
  ("例ちゃん", "reichan@aol.com", 15)
])
```

---

## 参考
 - [文字列関数/Google Cloud](https://cloud.google.com/bigquery/docs/reference/standard-sql/string_functions?hl=ja)
