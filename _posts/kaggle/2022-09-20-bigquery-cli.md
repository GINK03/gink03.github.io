---
layout: post
title: "bigquery cli"
date: 2022-09-20
excerpt: "bigquery cliのチートシート"
tags: ["bq", "bigquery", "gcp"]
kaggle: true
comments: false
sort_key: "2022-09-20"
update_dates: ["2022-09-20"]
---

# bigquery cliのチートシート

## 概要
 - コマンドからSQLの実行、データのロードができる
 - `gcloud`をインストールすると自動的に入るコマンド

## ユースケース別コマンド例
 - プロジェクトをセット
   - `gcloud set project <PROJECT-NAME>`
 - バケットを作成
   - `bq mk {PROJECT_NAME}:{BUCKET_NAME}`
 - テーブルを作成
   - 凡例
     - `bq mk {PROJECT_NAME}:{BUCKET_NAME}.{TABLE_NAME} {SCHEMA}`
   - 具体例
     - `bq mk --table starry-lattice-256603.attendances.logs ts:TIMESTAMP,message:STRING`
 - CSVをロード
   - 具体例
     - `bq load --replace --autodetect {SOME_PROJECT_NAME}:{BUCKET_NAME}.{TABLE_NAME} {ANY_CSV_PATH}`
   - オプション
     - `--replace`; 上書き許可
     - `--autodetect`; CSVの型の自動検出を試みる
 - ローカルのSQLを実行し、結果をテーブルに保存する 
   - 具体例
     - `bq query --nouse_legacy_sql --replace --destination_table {SOME_PROJECT_NAME}:{BUCKET_NAME}.{TABLE_NAME} < sql/foobar.sql`
 - テーブルをgcsにダンプ
   - 具体例
     - `bq extract --compression=GZIP {SOME_PROJECT_NAME}:{BUCKET_NAME}.{TABLE_NAME} "gs://{GCS_BUCKET_NAME}/dir_name/*.gz"`
