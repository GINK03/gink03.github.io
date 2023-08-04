---
layout: post
title: "bigquery except distinct"
date: 2023-08-04
excerpt: "bigquery except distinct集合演算子の使い方"
tags: ["bq", "bigquery", "gcp", "bigquery", "except distinct"]
kaggle: true
comments: false
sort_key: "2023-07-20"
update_dates: ["2023-07-20"]
---

# bigquery except distinct集合演算子の使い方

## 概要
 - `UNION ALL`, `INTERSECT DISTINCT`などの集合演算子の一つに`EXCEPT DISTINCT`というものがある
 - ２つのテーブルのレコードで集合と考えてsubstructionする操作

## pythonでのイメージ

```python
assert {(0, "a"), (1, "b"), (2, "c")} - {(0, "a"), (2, "c")} == {(1, "b")}
```

## 具体例

```sql
SELECT
  name,
  email
FROM UNNEST([
  STRUCT("山田 太郎" as name, "taro.yamada@example.com" as email),
  ("佐藤 花子", "hanako.sato@example.com"),
  ("鈴木 一郎", "ichiro.suzuki@example.com"),
  ("田中 二郎", "jiro.tanaka@example.com"),
  ("高橋 三郎", "saburo.takahashi@example.com")
])
EXCEPT DISTINCT
SELECT
  name,
  email
FROM UNNEST([
  STRUCT("山田 太郎" as name, "taro.yamada@example.com" as email),
  ("伊藤 由美", "yumi.itou@example.com")
])
```

| name      | email                        |
|-----------|------------------------------|
| 佐藤 花子 | hanako.sato@example.com      |
| 鈴木 一郎 | ichiro.suzuki@example.com    |
| 田中 二郎 | jiro.tanaka@example.com      |
| 高橋 三郎 | saburo.takahashi@example.com |

## 参考
 - [集合演算子/cloud.google.com](https://cloud.google.com/bigquery/docs/reference/standard-sql/query-syntax#set_operators)
