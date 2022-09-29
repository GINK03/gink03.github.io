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
   - pythonで動作させる場合、`flask`の`request`に相当する引数を与えることができる
 - デプロイ時に環境変数をセットすることができる
 - ユースケース
   - redisの内容を取得、更新するためのAPIを提供するなど
   - cloud functionsにはサービスアカウントを設定でき、アクセスせキュティを緩和できるので、他のAWSなどと連携するときに窓口として使える

## Pythonで使用する場合
 - `main.py`と依存が必要ならば、`requirements.txt`を用意する
 - どのバージョンのpythonで動作させるかを指定できる

```python
from flask import escape
import functions_framework

@functions_framework.http
def hello_http(request):
    request_json = request.get_json(silent=True)
    # getパラメータ
    request_args = request.args
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
    --region=asia-northeast2 \
    --set-env-vars ENV_VAR0=[ENV_VAR0],ENV_VAR1=[ENV_VAR1]
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

## 設定されたサービスアカウントを使用して、bearer tokenを取得する例

```python
import google.auth
import google.auth.transport.requests

def get_token(request):
    credentials, project = google.auth.default(
      scopes=['https://www.googleapis.com/auth/cloud-platform']
    )
    auth_req = google.auth.transport.requests.Request()
    credentials.refresh(auth_req)
    access_token = credentials.token
    return f'project = {project}, access_token = {access_token}'
```

---

## 参考
 - [PythonでHTTP Cloud Functionsの関数を作成してデプロイする](https://cloud.google.com/functions/docs/create-deploy-http-python)
 - [Cloud FunctionsからRedisインスタンスへの接続](https://cloud.google.com/memorystore/docs/redis/connect-redis-instance-functions?hl=ja#python_1)
