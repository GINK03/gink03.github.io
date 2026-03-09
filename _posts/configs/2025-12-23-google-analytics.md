---
layout: post
title: "Google Analytics"
date: 2025-12-23
excerpt: "Google Analyticsの使い方と活用法"
project: false
config: true
tag: ["google analytics", "ga4"]
comments: false
sort_key: "2025-12-23"
update_dates: ["2025-12-23"]
---

# Google Analyticsの使い方と活用法

## 概要
 - GA4のイベントデータはBigQueryにエクスポート可能
 - URLパラメータを活用してキャンペーン効果測定が可能
 - BigQueryでは`events_*`参照時に`_TABLE_SUFFIX`で期間指定が必須

## 広告ブロッカーの影響
 - `uBlock Origin Lite`などの広告ブロッカーを利用しているユーザーはGA4のトラッキングがブロックされる場合がある
 - キーマケLabの調査では 20〜70代1,498名のうち 34.3% が広告ブロッカー利用経験ありと回答 `2024-12-26〜2025-01-08` 実施
 - 上記はクラウドワークス経由のインターネット調査のため参考値として扱う
 - 一定割合のユーザーで計測漏れが発生しうるため主要指標の解釈では留意する

## 任意のURLパラメータ
 - UTMパラメータを使うとキャンペーン効果を追跡できる
 - UTM以外の任意パラメータも付与できる
 - 例: `?utm_source=name&utm_medium=referral&conversation_id=123e4567-e89b-12d3-a456-426614174000`

## tid(G-XXXXXXX)を特定する
 - google chromeのデベロッパーツールを開いてネットワークタブで`collect`を検索
 - リクエストのペイロードに`tid=G-XXXXXXX`の形式でGA4の測定IDが含まれている

## BigQueryへのエクスポート
 - GA4のイベントデータはBigQueryにエクスポート可能
 - 日次エクスポートは日本時間の1日単位で作成される
 - 反映は翌日の午前から午後のどこかになることがあるが 厳格な保証はない
 - 即時性が必要なら`events_intraday_*`の利用を検討する
 - 遅延を見込んで直近数日分を含めて再集計すると安心

## BigQueryでのクエリ例

```sql
-- セッション単位で見たい項目を抽出
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
  _TABLE_SUFFIX BETWEEN '20240101' AND '20251221';
```

```sql
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

## トラブルシューティング
 
### ログが取得できない
 - DNSなどでトラッキングがブロックされている
 - digコマンドで`www.google-analytics.com`の名前解決ができるか確認する

```console
$ dig www.google-analytics.com
```

## 参考
 - キーマケLab 広告ブロッカー利用調査 https://kwmlabo.com/survey_results/4387/
