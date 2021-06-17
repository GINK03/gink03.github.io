---
layout: post
title: "google app script"
date: 2021-06-01
excerpt: "google app scriptの使い方"
project: false
config: true
tag: ["google app script", "gss", "spreadsheet"]
comments: false
---

# google app scriptの使い方
 - [gss](/gss/)等で使用できるJavaScriptのスクリプト

## gssでの関数の作り方
 - [ツール] -> [スクリプトエディタ]

 1. 関数をイベントに紐付けるイメージ(C#に近い)
 2. ローカルで実行するには`[保存]` -> `[実行]`

### チートシート

**spreadsheet上のオブジェクトに関数を紐付ける**  
 - `画像等を貼り付ける` -> `画像のハンバーガーボタンを押して[スクリプトを割り当て]を選択` -> `関数名を入力する`  
   - オブジェクトに関数を割り当てると、左クリックか、二本指クリックでしかオブジェクトを操作できなくなる

**ログ**  
 - `Logger.log`
   - IDEで表示される
 - `Browser.msgBox`
   - gssでメッセージボックスで表示される

**タイマーを用いて処理をバッチ化する**  
 - `App Scriptの画面から[トリガー]を選択` -> `[トリガーを追加]を選択` -> `[時間主導型]を選択` -> `好きな時間粒度で選択`

**sheetのIDを取得**  
```js
var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
sheet.getSheetId();
```

**sheetの名前を取得**  
```js
var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
sheet.getName();
```

**操作しているユーザの取得**  
```js
Session.getEffectiveUser().getEmail();
```

**画像のダウンロードと挿入**  
```js
var image = "http://img.labnol.org/logo.png";
var blob = UrlFetchApp.fetch(image).getBlob();
var ss = SpreadsheetApp.getActiveSpreadsheet();
var sheet = ss.getActiveSheet();
sheet.insertImage(blob, 4, 3);
```

**セルの情報を読み込み**  
```js
var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
var values = sheet.getSheetValues(1,1,100, 3); // レンジで読み取っているのでアクセスするにはvalues[x][y]のようにする
Logger.log(JSON.stringify(values));
```

**特定のURLにpostデータを付けてアクセスする**  
```js
var data = {
  'name': 'Bob Smith',
  'age': 35,
  'pets': ['fido', 'fluffy']
};
var options = {
  'method' : 'post',
  'contentType': 'application/json',
  // Convert the JavaScript object to a JSON string.
  'payload' : JSON.stringify(data)
};
var response = UrlFetchApp.fetch("http://6c3a8d888880.ngrok.io", options);
Logger.log(response.getContentText());
```

**APIで取得したjson情報をパースしてシートに貼り付け**  
```js
var response = UrlFetchApp.fetch("http://6c3a8d888880.ngrok.io", options);
var data = JSON.parse(response.getContentText());
sheet.getRange(2, 1, data.length, data[0].length).setValues(data);
```

**localhostへのAPIへアクセスしたい**  
ngrokを使う  
ngrokでフォワードした上で  
```js
var response = UrlFetchApp.fetch("http://*****.ngrok.io");
Logger.log(response.getContentText());
```

**トーストの表示**  

```js
// トーストの開始
SpreadsheetApp.getActiveSpreadsheet().toast("なにか処理しています...",-1);
// トーストの終了
SpreadsheetApp.getActiveSpreadsheet().toast("完了.");
```

