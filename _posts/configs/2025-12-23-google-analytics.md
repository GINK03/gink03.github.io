---
layout: post
title: "google analytics"
date: 2025-12-23
excerpt: "google analyticsの使い方と活用法"
project: false
config: true
tag: ["google analytics", "ga4"]
comments: false
sort_key: "2025-12-23"
update_dates: ["2025-12-23"]
---

# google analyticsの使い方と活用法

## 概要
 - GA4のログはBigQueryにエクスポート可能
 - URLパラメータを活用してキャンペーン効果測定が可能
 - エクスポート先のBigQueryではテーブル日付サフィックスでパーティションを切っているため期間指定が必須

## 任意のURLパラメータの設定
 - UTMパラメータを使用して、キャンペーンの効果を追跡
 - 例: `?utm_source=name&utm_medium=referral&conversation_id=123e4567-e89b-12d3-a456-426614174000`

## BigQueryでのクエリ例

```sql
SELECT
  -- 1. ユーザーとセッションを一意に特定
  user_pseudo_id,
  (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS session_id,
  CONCAT(user_pseudo_id, '-', CAST((SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id') AS STRING)) AS unique_session_id,

  -- 2. 時間情報を人間が読める形式に (JST変換)
  event_date,
  DATETIME(TIMESTAMP_MICROS(event_timestamp), 'Asia/Tokyo') AS event_datetime,
  
  event_name,

  -- 3. 地理情報
  geo.region,
  geo.city,

  -- 4. ページ情報（NULL対応済み）
  (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_location') AS page_location,
  (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_referrer') AS page_referrer,

  -- 5. セッション単位の流入元（event_paramsから取得推奨）
  (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'source') AS session_source,
  (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'medium') AS session_medium

FROM
  `your-project.analytics_dataset.events_*`
WHERE
  -- コスト爆発を防ぐためパーティション指定は必須
  _TABLE_SUFFIX BETWEEN '20240101' AND '20251221'

-- ページ別のPV集計例
SELECT
  (SELECT value.string_value FROM UNNEST(event_params) WHERE key = 'page_location') AS page_location,
  COUNTIF(event_name = 'page_view') AS pageviews
FROM
  `your-project.analytics_dataset.events_*`
WHERE
  _TABLE_SUFFIX BETWEEN '20240101' AND '20251221'
GROUP BY
  page_location
```
