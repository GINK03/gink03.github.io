---
layout: post
title: "Google Sheets"
date: 2020-07-22
excerpt: "Google Sheetsの使い方"
project: false
config: true
tag: ["google sheets", "gss", "spreadsheets", "google spreadsheets"]
comments: false
---

# Google Sheets
 - excelのオンラインバージョンのアプリ
 - bigqueryと繋げられたり便利
 - 呼称のエイリアスが多くあり、`スプレッドシート`, `スプシ`, `GSS`などとも呼ばれる

---

## Google Apps Script/GAS

### 概要
 - `Microsoft Excel`のマクロに該当する機能  
 - 様々な具体例は[Google Developers](https://developers.google.com/apps-script/guides/sheets)に記されている。 

### Google Apps Scriptを開く
 - SpreadSheetの`[拡張機能]` -> `[Apps Script]`からスクリプトエディタを開くことができる。  

### ssidについて
 - URLに含まれるハッシュ値のようなものがssidでありスプレッドシート毎の固有値
 - ssidを指定してgasで操作可能

---

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

### column, rowの幅や高さを変える
 1. 幅や高さを変えたいcolumn, rowを選択
 2. 右クリックし`Resize columns...`または`Resize rows...`を選択
 3. 設定したい幅か高さのpixel数を入力する

### セルの中身を折り返して標示する
 1. テキスト位置のメニューの`|→|`のようなアイコンを選択
 2. `|⏎|`のようなアイコンにすると折返しになる
   - `|→|`; デフォルト。溢れた状態にするoverflow
   - `|⏎|`; 折返し。text wrapping
   - `|-|`; 溢れた文を消す。clip

---

## 大量のシートを含むデータをGoogle Sheetsにアップロードする場合
 - ユースケース
   - 機械学習による大量の推論結果をGoogle Sheets経由でシェアする場合
 - 手順
   - pandasから一時的にExcelに出力
   - Excelファイルを`スプレッドシートの置換`でインポート
     - 大量のデータをインポートすると、`Google ドキュメント内でエラーが発生しました~`と出るが、リロードを行うと、正常に反映される 

---

## アドオン関連
 - アドオンの追加
   - `[拡張機能]` -> `[アドオンを取得]`

### OWOX BI BigQuery
 - 概要
   - 無料版のgoogleアカウントだとbigquery連携(データコネクタ)が使えないが、このアドオンを利用するとSQLを実行することができる
 - 参考
   - [BigQueryとスプレッドシートを連携する方法(無料プラグイン使用)](https://roi-log.com/2021/09/11/bigquery-spreadsheet-integration/)
