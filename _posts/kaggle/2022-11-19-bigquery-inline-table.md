---
layout: post
title: "bigquery inline table"
date: 2022-11-19
excerpt: "bigqueryインラインテーブルの使い方"
tags: ["bq", "bigquery", "gcp", "inline table"]
kaggle: true
comments: false
sort_key: "2022-11-19"
update_dates: ["2022-11-19"]
---

# bigqueryインラインテーブルの使い方

## 概要
 - テーブルにアクセスしなくても簡単なSQLのテストを行える
   - 複雑な機能や関数を試すときに便利な機能
 - `STRUCTのARRAYをUNNEST`することで簡潔に記すことができる

## 具体例

```sql
SELECT
  id,
  name,
  email,
FROM UNNEST([
  STRUCT(1 AS id, "abc" AS name, "abc@google.com" as email),
  (2, "abcd", "abcd@microsoft.com"),
  (3, "例子", "reiko@google.com"),
  (4, "例夫", "reio@yahoo.com"),
  (5, "例ちゃん", "reichan@aol.com")
])
```

---

## 参考
 - [BigQuery create small sample table all in one query/stackoverflow](https://stackoverflow.com/questions/58121195/bigquery-create-small-sample-table-all-in-one-query)
