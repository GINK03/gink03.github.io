---
layout: post
title: "flask x-api-key"
date: 2022-10-06
excerpt: "flaskでのx-api-keyの取り扱い"
project: false
config: true
tag: ["flask", "api", "セキュリティ"]
comments: false
sort_key: "2022-10-06"
update_dates: ["2022-10-06"]
---

# flaskでのx-api-keyの取り扱い

## 概要
 - flaskでサービングしているAPIに対して簡易的なセキュリティをかけるのに使える
 - よりロバストなセキュリティがほしいのであれば、Bearer token等を使う

## 具体例
 - ヘッダーに`{"x-api-key": "asoidewfoef"}`が設定されていると仮定する

```python
from flask import Flask, request, jsonify 

app = Flask(__name__) 
@app.route('/') 
def index(): 
	headers = request.headers 
	auth = headers.get("x-api-key") 
	if auth == 'asoidewfoef': 
		return jsonify({"message": "OK: Authorized"}), 200 
	else: 
		return jsonify({"message": "ERROR: Unauthorized"}), 401
```
