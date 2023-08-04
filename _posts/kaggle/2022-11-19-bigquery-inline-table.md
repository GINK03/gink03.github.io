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
  name,
  email
FROM UNNEST([
  STRUCT("山田 太郎" as name, "taro.yamada@example.com" as email),
  ("佐藤 花子", "hanako.sato@example.com"),
  ("鈴木 一郎", "ichiro.suzuki@example.com"),
  ("田中 二郎", "jiro.tanaka@example.com"),
  ("高橋 三郎", "saburo.takahashi@example.com")
])
```

---

## 参考
 - [BigQuery create small sample table all in one query/stackoverflow](https://stackoverflow.com/questions/58121195/bigquery-create-small-sample-table-all-in-one-query)
