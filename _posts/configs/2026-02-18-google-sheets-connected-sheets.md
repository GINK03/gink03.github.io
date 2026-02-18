---
layout: post
title: "Google Sheets Connected Sheetsの使い方"
date: 2026-02-18
excerpt: "Google Sheets Connected Sheetsの使い方"
config: true
tag: ["Google Sheets", "Connected Sheets", "BigQuery", "データコネクタ"]
comments: false
sort_key: "2026-02-18"
update_dates: ["2026-02-18"]
---

# Google Sheets Connected Sheetsの使い方

## 概要
 - Google SheetsからBigQueryのデータを直接参照できる機能
 - 2023年前後から 個人のGoogleアカウントや ほぼすべてのGoogle Workspaceアカウントで利用できるようになった

## 基本的な使い方
 1. `[データ]` > `[データコネクタ]` > `[BigQuery]` を選択
 2. BigQueryのプロジェクトとデータセットを選択 または SQLクエリを入力

## 必要な権限
 - `roles/bigquery.dataViewer`
 - `roles/bigquery.jobUser`

## 便利な使い方
 - 複雑な前処理はBigQuery側で行い 可視化はスプレッドシート側で行う
