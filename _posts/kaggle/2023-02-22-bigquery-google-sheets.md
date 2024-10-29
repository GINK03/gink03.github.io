---
layout: post
title: "bigqueryでgoogle sheetsのデータを参照"
date: 2023-02-22
excerpt: "bigqueryでgoogle sheetsのデータを参照する方法"
tags: ["bq", "bigquery", "gcp", "google sheets"]
kaggle: true
comments: false
sort_key: "2023-02-22"
update_dates: ["2023-02-22"]
---

# bigqueryでgoogle sheetsのデータを参照する方法

## 概要
 - google sheetsでまとめたデータをbigqueryで参照・使用できるように設定する方法
 - 使用するコマンドが多く手順が複雑

## 手順
 - `gcloud` コマンドでgoogle driveへのアクセスを許可する
 - `bq mkdef` コマンドで定義テンプレートを作成する
 - 定義テンプレートを編集し[/google sheets/](/google-sheets/)の参照先シート・参照範囲と型を指定する
 - `bq mk`コマンドで定義テンプレートを参照しテーブルを作成

### google driveへのアクセスを許可

```console
# gcloud auth loginを使用する場合
$ gcloud auth login --enable-gdrive-access
# gcloud auth application-default loginを使用する場合
$ gcloud auth application-default login --scopes=https://www.googleapis.com/auth/cloud-platform,https://www.googleapis.com/auth/bigquery,https://www.googleapis.com/auth/drive
```

### `bq mkdef`コマンドで定義テンプレートを作成する

```console
$ bq mkdef <url> > bq_def.json
```

### 定義テンプレートを編集しgoogle sheetsの参照先シート・参照範囲と型を指定する
 - `sourceUris`: google sheetsのURL
 - `googleSheetsOptions : range`: 参照するシート名・カラム
 - `schema`: 型

```json
{
  "sourceFormat": "GOOGLE_SHEETS",
  "sourceUris": [
    "https://docs.google.com/spreadsheets/d/1wTr9fmtF3YG_lQMehYjAnDzgKmJ92g-8yvFtYctrbB4"
  ],
  "googleSheetsOptions":{
    "range":"Sheet1!A:C",
    "skipLeadingRows":1
  },
  "schema":{
    "fields":[
      {"name":"name",    "type":"STRING", "mode":"NULLABLE"},
      {"name":"sex",     "type":"STRING", "mode":"NULLABLE"},
      {"name":"age",     "type":"STRING", "mode":"NULLABLE"},
    ]
  }
}
```

### `bq mk`コマンドで定義テンプレートを参照しテーブルを作成

```console
$ bq mk --external_table_definition="./bq_def.json" \
    <project-name>:<dataset-name>.<table-name>
# 成功時のメッセージ
# Table 'xxxx:yyyy.zzzz' successfully created.
```

### 確認

```sql
SELECT
  *
FROM
  `xxxx.yyyy.zzz`
```

```txt
name,      sex,    age
suzuki,    male,   20
yamada,    female, 21
kobayashi, female, 18
```

## 参考
 - [GoogleスプレッドシートをデータソースとするBigQuery外部テーブルをCLIで作成する](https://dev.classmethod.jp/articles/202109-google-spreadsheet-bigquery-external-table-with-cli/)
