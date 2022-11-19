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
   - timestampは範囲が`1970-01-01 00:00:01(UTC) ~ 2038-01-19 03:14:07(UTC)`
   - datetimeは`1000-01-01 00:00:00 ~ 9999-12-31 23:59:59`
     - timezoneのリファレンス情報を取得しない
 - webUIの`スキーマ`から確認できる

## `datetime`の情報を`DATETIME_TRUNC`関数を使用して粒度を揃える
 - 切り詰めることで様々な粒度にできる
   - `DAY`, `WEEK`, `HOUR`, `MINUTE`など

```sql
SELECT
  *,
  DATETIME_TRUNC(created_at, DAY) as day, -- DAYの粒度で切り詰めて揃える
FROM 
  `table`
```

## 集計時点の日時の情報を追加する
 - `CURRENT_DATETIME関数を用いる`
 - タイムゾーンを指定するときには、引数で文字列で与える

```sql
SELECT
  id,
  name,
  email,
  CURRENT_DATETIME("Asia/Tokyo") as dt,
FROM UNNEST([
  STRUCT(1 AS id, "abc" AS name, "abc@google.com" as email),
  (2, "abcd", "abcd@microsoft.com"),
  (3, "例子", "reiko@google.com"),
  (4, "例夫", "reio@yahoo.com"),
  (5, "例ちゃん", "reichan@aol.com")
])
```

### 参考
 - [DATETIME_TRUNC/データポータル](https://support.google.com/datastudio/answer/9729685?hl=ja)
 - [What difference between the DATE, TIME, DATETIME, and TIMESTAMP Types/stackoverflow](https://stackoverflow.com/questions/31761047/what-difference-between-the-date-time-datetime-and-timestamp-types)

