---
layout: post
title: "bigquery timestamp"
date: 2022-09-20
excerpt: "bigquery timestampのチートシート"
tags: ["bq", "bigquery", "gcp", "timestamp"]
kaggle: true
comments: false
sort_key: "2022-09-20"
update_dates: ["2022-09-20"]
---

# bigquery timestampのチートシート


## 具体例

### 今の時間から差分を計算

```sql
TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), last_login, DAY) as days_from_last_login
```

### STRFTIME, FORMAT_TIMESTAMP(timestampをstring型のデータへ変換)

```sql
FORMAT_TIMESTAMP("%Y-%m-%d", timestamp)
```

### TIMESTAMP; unix time, epoch timeをtimestamp型に変換する

```sql
SELECT TIMESTAMP_SECONDS(1230219000)       -- 2008-12-25 15:30:00 UTC
SELECT TIMESTAMP_MILLIS(1230219000000)     -- 2008-12-25 15:30:00 UTC
SELECT TIMESTAMP_MICROS(1230219000000000)  -- 2008-12-25 15:30:00 UTC
```

### STRING型をdate型に変換する

```sql
SELECT DATE(TIMESTAMP_SECONDS(1230219000)) -- 2008-12-25
SELECT CAST('2008-12-25' AS DATE)          -- 2008-12-25
SELECT DATE('2008-12-25', 'UTC')           -- 2008-12-25
```

---

## 参考
 - [タイムスタンプ関数/Google Cloud](https://cloud.google.com/bigquery/docs/reference/standard-sql/timestamp_functions)
