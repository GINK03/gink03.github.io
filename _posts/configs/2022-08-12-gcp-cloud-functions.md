---
layout: post
title: "gcp cloud functions"
date: "2022-08-11"
excerpt: "gcp cloud functionsの使い方"
config: true
tag: ["gcp", "gcloud", "cloud functions"]
comments: false
sort_key: "2022-08-12"
update_dates: ["2022-08-12"]
---

# gcp cloud functionsの使い方

## 概要
 - python, nodejs, goで関数単位でデプロイできるクラウドサービス
 - redisの内容を取得、更新するためのAPIを提供するなど

## Pythonで使用する場合
 - `main.py`と依存が必要ならば、`requirements.txt`を用意する
 - どのバージョンのpythonで動作させるかを指定できる

```python
from flask import escape
import functions_framework

@functions_framework.http
def hello_http(request):
    if request_json and 'name' in request_json:
        name = request_json['name']
    elif request_args and 'name' in request_args:
        name = request_args['name']
    else:
        name = 'World'
    return 'Hello {}!'.format(escape(name))
```

**デプロイ**
```console
$ gcloud functions deploy hello_http \
    --runtime python310 \
    --trigger-http \
    --allow-unauthenticated \
    --region=asia-northeast2
```

**プロパティの確認**
```console
$ gcloud functions describe hello_http
```

**テストクエリ**
```console
$ curl "https://asia-northeast2-starry-lattice-256603.cloudfunctions.net/hello_http?name=うんち"
Hello うんち!
```

---

## ローカルでの開発について
`functions-framework`というソフトウェアを使い、ローカルにサーバを立ててテストする 
 
```console
$ functions_framework --target=<function-name>
```
  
 - 参考
   - [Function Frameworks を使用した関数の実行](https://cloud.google.com/functions/docs/running/function-frameworks)

---

## 参考
 - [PythonでHTTP Cloud Functionsの関数を作成してデプロイする](https://cloud.google.com/functions/docs/create-deploy-http-python)
