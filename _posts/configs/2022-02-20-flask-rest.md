---
layout: post
title: "flask rest"
date: 2022-02-20
excerpt: "flaskでrestの使い方"
project: false
config: true
tag: ["flask", "rest", "api"]
comments: false
sort_key: "2022-04-07"
update_dates: ["2022-04-07","2022-02-26","2022-02-20"]
---

# flaskでrestの使い方"

## 概要
 - flaskでAPIを作成する際のテンプレート

### RESTアーキテクチャがサポートする投稿方式
 - `GET`
   - データの取得
 - `POST`
   - データの投稿
 - `PUT`
   - データの挿入
 - `PATCH`
   - データの変更
 - `DELETE`
   - データの削除 

---

## アクセス可能IPとポートの設定の例

```python
app.run(host="0.0.0.0", port=5000)
```
 - `host`
   - アクセス可能なIP
 - `port`
   - 起動時のポート 

---

## flaskによるrestに対応した最小限のサーバの実装例

```python
from flask import Flask, request, jsonify
import json

app = Flask(__name__)
data = {"a": ["v0", "v1", "v2"], "b": ["v4"]}

# 取得
@app.route('/', methods=["GET"])
def get_api():
    user = request.args.get("user")
    return 'get; ' + json.dumps(data.get(user))

# 新規レコードの追加
@app.route('/', methods=["POST"])
def post_api():
    user = request.args.get("user")
    value = request.args.get("values")
    data[user] = value
    return 'post; ' + json.dumps(data)


# 値のアップデートや代入
@app.route('/', methods=["PUT", "PATCH"])
def put_api():
    user = request.args.get("user")
    value = request.args.get("values")
    data[user] = value
    return 'put; ' + json.dumps(data)

# レコードの削除
@app.route('/', methods=["DELETE"])
def delete_api():
    user = request.args.get("user")
    del data[user]
    return 'delete; ' + json.dumps(data)

if __name__ == '__main__':
    app.run(debug=True)
```

## flaskでステータスコードとメッセージを返すとき

```python
@app.route('/', methods=['GET', 'POST'])
def home():
    # キーによる認証
    if request.headers.get('x-api-key') != "xxxxxxxxxxxxx":
        return "invalid access.", 400
    ...
```

---

## restに対応したAPIにアクセスする最小限のクライアントの実装例


### GETでデータを送るとき

```python
import requests

URL = "http://localhost:5000/"
data = {"a": ["v0", "v1", "v2"], "b": ["v4"]}

with requests.get(URL, params={"user": "a"}) as r:
    print(r.text)

with requests.post(URL, params={"user": "c", "values": 1}) as r:
    print(r.text)

with requests.delete(URL, params={"user": "a", "values": 1}) as r:
    print(r.text)
```

### POSTとjsonでデータを送るとき

```python
import requests
import json
URL = "http://localhost:8080/"

params = {"mode": "m1", "p1": ["https"]}
headers = {"x-api-key": "660df3bae494e5bc8d76d"}
with requests.post(URL, json=params, headers=headers) as r:
    print(r.text)
```

