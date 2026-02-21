---
layout: post
title: "BigQuery の SELECT * EXCEPT / REPLACE"
date: 2026-02-21
excerpt: "BigQuery の SELECT * EXCEPT と REPLACE の使い方メモ"
tag: ["bigquery", "sql"]
kaggle: true
comments: false
sort_key: "2026-02-21"
update_dates: ["2026-02-21"]
---

# BigQuery の SELECT * EXCEPT / REPLACE

## 概要

 - `SELECT * EXCEPT(...)` で不要な列を除外できる
 - `SELECT * REPLACE(...)` で既存の列を式で上書きできる
 - JOIN 時の重複キー列を消したいときにも便利

## 使用例

### SELECT * EXCEPT の基本

```sql
SELECT
  * EXCEPT(email, phone)
FROM
  `project.dataset.users`;
```

### JOIN での重複キー列の解消

```sql
SELECT
  a.*,
  b.* EXCEPT(user_id)
FROM
  table_a AS a
JOIN
  table_b AS b
USING(user_id);
```

### SELECT * REPLACE の基本

```sql
-- salary を年収（×12）に上書き
SELECT
  * REPLACE(salary * 12 AS salary)
FROM
  `project.dataset.employees`;

-- 文字列を大文字に変換
SELECT
  * REPLACE(UPPER(first_name) AS first_name)
FROM
  `project.dataset.employees`;
```
