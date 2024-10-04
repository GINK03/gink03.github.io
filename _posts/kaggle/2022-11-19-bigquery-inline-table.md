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
 - インラインテーブルを利用することで、一時的な変数を作成することができる
   - 実行タイミングに依存するようなデータを作成するときに便利
 - インラインテーブルを利用することで、テーブルにアクセスしなくても簡単なSQLのテストを行える
   - 複雑な機能や関数を試すときに便利な機能
 - `STRUCTのARRAYをUNNEST`することで簡潔に記すことができる

## 具体例

**現在時間から一時的な変数を作成する**
```sql
-- 現在日時から特定の期間を計算して、期間ごとにデータを分類する
date_ranges as (
  select
    datetime_sub(current_datetime(), interval 14 day) as two_weeks_ago,  -- 2週間前
    datetime_sub(current_datetime(), interval 56 day) as eight_weeks_ago  -- 8週間前
),

select
    ts,
    user,
    event,
    case
      when ts >= (select two_weeks_ago from date_ranges) then 'Last2Weeks'
      when ts >= (select eight_weeks_ago from date_ranges) and ts < (select two_weeks_ago from date_ranges) then '2WeeksTo8WeeksAgo'
      else 'Older'
    end as period
from
    `...`
where
    ts >= (select eight_weeks_ago from date_ranges)
```

**STRUCTのARRAYをUNNESTする**
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
