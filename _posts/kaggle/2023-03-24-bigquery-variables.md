---
layout: post
title: "bigquery variables"
date: 2023-03-24
excerpt: "bigqueryでの変数(variables)の使い方"
tags: ["bq", "bigquery", "gcp", "bigquery", "variables", "procedural-language"]
kaggle: true
comments: false
sort_key: "2023-03-24"
update_dates: ["2023-03-24"]
---

# bigqueryでの変数(variables)の使い方

## 概要
 - `DECLARE`と`SET`を組み合わせて変数を定義できる
 - BigQueryのprocedural-language(手続き型言語)の機能の一部
 - クエリの先頭の部分に書く
   - withステートメントより先に書ける

## 変数を宣言する

```sql
DECLARE x INT64
DECLARE y STRING
```
 - `x`を整数型で、`y`を文字列型で宣言

## 変数に値を代入する

```sql
SET x = 100;
SET y = "a|i|u|e|o"
```
 - `x`に`100`を代入、`y`に`"a|i|u|e|o"`を代入

---

## 参考
 - [手続き型言語/cloud.google.com](https://cloud.google.com/bigquery/docs/reference/standard-sql/procedural-language?hl=ja)
