---
layout: post
title: "flask rest"
date: 2022-02-20
excerpt: "flaskでrestの使い方"
project: false
config: true
tag: ["flask", "rest", "api"]
comments: false
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

## restに対応したAPIにアクセスする最小限のクライアントの実装例

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