---
layout: post
title: "bigqueryb date(datetime)"
date: 2020-06-26
excerpt: "bigqueryの時間機能"
tags: ["bq", "bigquery", "gcp"]
kaggle: true
comments: false
sort_key: "2022-09-06"
update_dates: ["2022-09-06"]
---

# bigqueryの時間機能

## カラムの型情報の確認
 - timestamp型とdatetime型は別のもの
 - webUIの`スキーマ`から確認できる

## `datetime`の情報を`datetime_trunc`関数を使用して粒度を揃える
 - 様々な粒度にできる
   - `DAY`, `WEEK`, `HOUR`, `MINUTE`など

```sql
SELECT
  *,
  DATETIME_TRUNC(created_at, DAY) as day,
FROM 
  `table`
```

### 参考
 - [DATETIME_TRUNC/データポータル](https://support.google.com/datastudio/answer/9729685?hl=ja)

