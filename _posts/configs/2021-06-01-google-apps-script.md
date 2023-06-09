---
layout: post
title: "google apps script"
date: 2021-06-01
excerpt: "google apps scriptの使い方"
project: false
config: true
tag: ["gas", "google apps script", "spreadsheets"]
comments: false
sort_key: "2022-04-16"
update_dates: ["2022-04-16","2022-04-01","2022-03-09","2022-02-27","2022-02-27","2022-02-10"]
---

# google apps scriptの使い方
 - [google spreadsheets](/google-spreadsheets/)等で使用できるJavaScriptのスクリプト 
 - 短縮表現は`GAS(ガス)`

## google spreadsheetsでの関数の作り方
 - `[拡張機能]` -> `[Apps Script]`

 1. 関数をイベントに紐付けるイメージ(C#に近い)
 2. ローカルで実行するには`[保存]` -> `[実行]`

### チートシート

#### spreadsheet上のオブジェクトに関数を紐付ける
 - `画像等を貼り付ける` -> `画像のハンバーガーボタンを押して[スクリプトを割り当て]を選択` -> `関数名を入力する`  
   - オブジェクトに関数を割り当てると、左クリックか、二本指クリックでしかオブジェクトを操作できなくなる

#### ログ
 - `Logger.log`
   - IDEで表示される
 - `Browser.msgBox`
   - gssでメッセージボックスで表示される

#### タイマーを用いて処理をバッチ化する
 - `App Scriptの画面から[トリガー]を選択` -> `[トリガーを追加]を選択` -> `[時間主導型]を選択` -> `好きな時間粒度で選択`
 - タイマーの制限
   - 毎日、時間という粗い粒度で設定できるが詳細な分単位の時間では設定できない
     - ok; `11時 ~ 12時`
     - ng; `11:45`

#### アクティブなsheetのIDを取得

```js
var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
sheet.getSheetId();
```

#### アクティブなsheetの名前を取得

```js
var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
sheet.getName();
```

#### ssのIDを指定してss, sheetのインスタンスを取得

```js
var ssid_target = "16V6Xzup9zp******************";
var ss_target = SpreadsheetApp.openById(ssid_target);
var sheet = ss_target.getSheetByName("シート1");
```

#### 操作しているユーザの取得

```js
Session.getEffectiveUser().getEmail();
```

#### 画像のダウンロードと挿入

```js
var image = "http://img.labnol.org/logo.png";
var blob = UrlFetchApp.fetch(image).getBlob();
var ss = SpreadsheetApp.getActiveSpreadsheet();
var sheet = ss.getActiveSheet();
sheet.insertImage(blob, 4, 3);
```

#### セルの情報を読み込み

```js
var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
var values = sheet.getSheetValues(1,1,100, 3); // レンジで読み取っているのでアクセスするにはvalues[x][y]のようにする
Logger.log(JSON.stringify(values));
```

#### シートにかかれているすべての情報を読み込み、必要なカラムだけ抽出する

```js
var sheet = SpreadsheetApp.getActiveSpreadsheet().getActiveSheet();
var lastRow = sheet.getLastRow();
var lastColumn = sheet.getLastColumn();

var values = sheet.getSheetValues(1,1,lastRow,lastColumn);
cols = values[0];
// id, title, contentをパース
obj = {"id": [], "title":[], "content": []};
for (let col_idx = 0; col_idx < cols.length; col_idx++) {
  if(cols[col_idx] == "id" || cols[col_idx] == "title" || cols[col_idx] == "content") {
    col_name = cols[col_idx];
    for(let row_idx = 1; row_idx < values.length; row_idx++) {
      obj[col_name].push(values[row_idx][col_idx]);
    }
  } 
}
```
 - `sheet.getLastColumn()`, `sheet.getLastRow()`でデータが入っている最大の範囲を取得できる
 - `obj`で必要なカラムのデータだけを取得する


#### 特定のURLにpostデータを付けてアクセスする

```js
var data = {
  'name': 'Bob Smith',
  'age': 35,
  'pets': ['fido', 'fluffy']
};
var headers = {
  "x-api-key": "jFyeYNPaTn8jG3WLnfn*******************"
};
var options = {
  'method' : 'post',
  'headers': headers,
  'contentType': 'application/json',
  // Convert the JavaScript object to a JSON string.
  'payload' : JSON.stringify(data)
};
var response = UrlFetchApp.fetch("http://6c3a8d888880.ngrok.io", options);
Logger.log(response.getContentText());
```
 - `x-api-key`はAPIのキーとなる
 - `UrlFetchApp.fetch(...)`はpostメソッドでのアクセスのみサポートであり、サーバサイドではgetのような用途であっても`post`で受け取る必要がある

#### sheet.getRange関数
 - 範囲の操作オブジェクトインスタンスを返す関数

```js
sheet.getRange(row_start_index, col_start_index, row_size, col_size)
```
 - `row_start_index`
   - ROWの始点
 - `col_start_index`
   - COLの始点
 - `row_size`
   - 選択するROWのサイズ
 - `col_size`
   - 選択するCOLのサイズ

#### APIで取得したjson情報をパースしてシートに貼り付け

```js
var response = UrlFetchApp.fetch("http://6c3a8d888880.ngrok.io", options);
var data = JSON.parse(response.getContentText());
sheet.getRange(2, 1, data.length, data[0].length).setValues(data);
```
 - `data`は`[[col1, col2, ..., colN], [val1, val2, ..., valN], ...]`というデータ形式 
   - dataの最初の要素がcolumn情報になっている

#### セルを指定して最後のセルにデータを貼り付け

```js
append_cols = ["score1", "score2", "score3"];

for (const [index, append_col] of append_cols.entries()) {
  const last_col_idx = sheet.getLastColumn();
  sheet.getRange(1, last_col_idx + 1).setValue(append_col);
  for(let row_idx = 1; row_idx < values.length; row_idx++) {
    sheet.getRange(1 + row_idx, last_col_idx + 1).setValue("VALUE");
  }
}
```
 - 範囲指定しない挿入は遅い

#### 選択したrangeオブジェクトの書式を一括設定

```js
var range = sheet.getRange(row_start_index, col_start_index, row_size, col_size)
range.setNumberFormat("#,##0.00")
```
 - 参考
   - [【GAS】スプレッドシートの表示形式で数字フォーマットを変更する方法(setNumberFormat)](https://auto-worker.com/blog/?p=3814)

#### rangeの値をまとめて消去

```js
sheet.getRange("E2:M" + sheet.getLastRow()).clear({ contentsOnly: true, skipFilteredRows: false });
```
 - カラムを指定する文字を利用してヘッダー以外の値をクリアすることができる

#### カラムの移動

```js
const sheet = SpreadsheetApp.getActiveSpreadsheet().getSheetByName("Sheet1");
sheet.moveColumns(sheet.getRange("A1"), 3);
```
 - 参考
   - [how to swap columns in google sheets/StackOverflow](https://stackoverflow.com/questions/62252784/how-to-swap-columns-in-google-sheets)

#### localhostへのAPIへアクセスしたい
 - ngrokを使う  

```js
var response = UrlFetchApp.fetch("http://*****.ngrok.io");
Logger.log(response.getContentText());
```

#### トーストの表示

```js
// トーストの開始
SpreadsheetApp.getActiveSpreadsheet().toast("なにか処理しています...", "タイトル",-1);
// トーストの終了
SpreadsheetApp.getActiveSpreadsheet().toast("完了.");
```
 - 引数の順序が `toast(description, title, option)`であることに注意

#### GASからOAuthでのアクセス認証があるCloud Functions/Runにアクセスする
 - 手順
   - Apps Scriptの`Project Settings`からアクセス対象のGCPプロジェクトnumberを設定する
   - `appscript.json`で`"oauthScopes": [ "openid", "https://www.googleapis.com/auth/script.external_request", ...]`を設定する
   - 認証制御付きのCloud Functions/Runを作る
     - 古いものはアクセスできない
   - `identityToken`をheaderに設定することでアクセス可能なる
 - 参考
   - [Google Apps Script 経由で Google Cloud Function を安全に呼び出す](https://stackoverflow.com/questions/61781421/securely-calling-a-google-cloud-function-via-a-google-apps-script)

```js
function parseJwt(token) {
  var body = token.split('.')[1];
  var decoded = Utilities.newBlob(Utilities.base64Decode(body)).getDataAsString();
  var payload = JSON.parse(decoded);
  var profileId = payload.sub;
  return payload
};

function myFunction() {
  let id_token = ScriptApp.getIdentityToken();
  Logger.log(id_token);
  Logger.log(parseJwt(id_token));

  var url = 'https://function-1-********-an.a.run.app'; // 置き換えてください
  var options = {
    method: 'post',
    headers: {
      'Authorization': 'Bearer ' + id_token,
      'Content-Type': 'application/json'
    },
    payload: JSON.stringify({
      name: 'Hello World'
    })
  };
  
  var response = UrlFetchApp.fetch(url, options);
  Logger.log(response.getContentText());
}
```

---

## 例; コンピュートエンジンの自動停止

```js
var token = ScriptApp.getOAuthToken();
var options = {
  'method' : 'post',
  'contentType': 'application/json',
  headers: {'Authorization': 'Bearer ' + token}
};
STOP_INSTANCES_URL = "https://www.googleapis.com/compute/v1/projects/%s/zones/%s/instances/%s/stop";
var target = Utilities.formatString(STOP_INSTANCES_URL, "starry-lattice-256603", "asia-northeast1-b", "my-vm");
var results = UrlFetchApp.fetch(target, options);
Logger.log(results);
```

---

## トラブルシューティング
 - 問題
   - スクリプトを時間でトリガーしている場合、トリガーの製作者以外、削除や変更ができない
 - 解決策
   - 属人化を一部許容して、トリガーの編集者を誰か任命するなど

--- 

## 参考になったページ
 - [GASでCompute Engineの時間に応じた自動停止/起動ツールを作成する 〜GASで簡単に好きなGoogle APIを叩く方法〜](https://www.kabuku.co.jp/developers/gcs-auto-scheduler-by-gas)
