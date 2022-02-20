---
layout: post
title: "spreadsheet"
date: 2020-07-22
excerpt: "spreadsheet"
project: false
config: true
tag: ["gspread", "gss", "spreadsheets", "google spreadsheets"]
comments: false
---

# google spreadsheets
 - excelのオンラインバージョン
 - bigqueryと繋げられたり便利

## Google Apps Script/gas

### 概要
 - `Microsoft Excel`のマクロに該当する機能  
 - 様々な具体例は[Google Developers](https://developers.google.com/apps-script/guides/sheets)に記されている。 

### Google Apps Scriptを開く
 - SpreadSheetの`[拡張機能]` -> `[Apps Script]`からスクリプトエディタを開くことができる。  

### ssidについて
 - URLに含まれるハッシュ値のようなものがssidでありスプレッドシート毎の固有値
 - ssidを指定してgasで操作可能

## 基本的な操作

### 日付の表示を %Y-%m-%d に
 - `[表示形式]` -> `[数字]` -> `[表示形式の詳細設定]` -> `[その他の日付や時刻の設定]`

### csv fileのインポート
 - `[ファイル]` -> `[インポート]` -> `[アップロード]`

### Queryを使う 

 - SpreadSheet上のデータに対して、SQLのようなクエリを使うことができる。  

```
  A	B
1	name	val
2	a	10
3	b	20
4	c	30
5	a	15
6	b	40
```

以上のようなデータがあった際に、Bのカラムの平均や合計  
 - `=QUERY(B2:B6, "SELECT AVG(B), SUM(B)", -1)`  

Aに対してGROUP BY操作のようなこともできる  
 - `=QUERY(A2:B6, "SELECT A, AVG(B), SUM(B) GROUP BY A", -1)`  

 - [具体例のリンク](https://docs.google.com/spreadsheets/d/1-5ZqObw858VAQ-NuYMB2Et21EfMEPPrJjxpZR-rD5DI/edit?usp=sharing)

### セレクトボックを作る
 1. `[Data]` -> `[Data Validation]` -> `クライテリアを入力して、"Show dropdown list in cell"を選ぶ`

## アドオン関連
 - アドオンの追加
   - `[拡張機能]` -> `[アドオンを取得]`

### OWOX BI BigQuery
 - 概要
   - 無料版のgoogleアカウントだとbigquery連携(データコネクタ)が使えないが、このアドオンを利用するとSQLを実行することができる
 - 参考
   - [BigQueryとスプレッドシートを連携する方法(無料プラグイン使用)](https://roi-log.com/2021/09/11/bigquery-spreadsheet-integration/)
