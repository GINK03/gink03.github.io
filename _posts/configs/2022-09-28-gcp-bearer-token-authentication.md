---
layout: post
title: "gcp bearer token authentication"
date: "2022-09-28"
excerpt: "gcp bearer token authenticationの使い方"
config: true
tag: ["gcp", "gcloud", "security", "bearer", "token authentication"]
comments: false
sort_key: "2022-09-28"
update_dates: ["2022-09-28"]
---

# gcp bearer token authenticationの使い方

## 概要
 - GCPのサービスにREST APIで接続する際に認証として必要なトークンを出力する機能
 - トークンはサービスアカウントのクレデンシャルから生成できる
 - トークンはAPIのヘッダに所定のフォーマットで設定する
 - ユースケース
   - AWSのシステムから、GCPのAPIにアクセスする
   - ローカルPCから、GCPのAPIにアクセスする

## pythonで必要なモジュール

```text
google-auth
google-api-python-client
google-auth-httplib2
google-auth-oauthlib
```

## 具体例: デフォルトのサービスアカウントでトークンを生成する

```python
import google.auth
import google.auth.transport.requests

credentials, project = google.auth.default(
        scopes=['https://www.googleapis.com/auth/cloud-platform']
        )

auth_req = google.auth.transport.requests.Request()
credentials.refresh(auth_req)
access_token = credentials.token

print(project) # プロジェクト名
print(access_token)
```

## 具体例: cloud functionsへのリクエストをSAのクレデンシャルで行う


```python
import requests
from pathlib import Path

from google.oauth2 import service_account
from google.auth.transport.requests import Request

# サービスアカウントのJSONキーのパス
SERVICE_ACCOUNT_FILE = Path(
    "~/.var/*************************.json"
).expanduser()

# 呼び出し先のエンドポイント URL (audience)
TARGET_URL = "https://****************************.cloudfunctions.net/get_range"

# サービスアカウントから、指定のaudience用のIDトークンを扱う資格情報を生成
credentials = service_account.IDTokenCredentials.from_service_account_file(
    SERVICE_ACCOUNT_FILE,
    target_audience=TARGET_URL,  # Cloud Functions/Run で指定するaudience
)

# トークンを最新状態に更新
request_adapter = Request()
credentials.refresh(request_adapter)

# 取得した ID トークンを Authorization ヘッダーにセット
headers = {
    "Authorization": f"Bearer {credentials.token}",
    "Content-Type": "application/json",
}

# 必要に応じて送信するボディがあれば、ここで定義（今回は空の JSON を送信）
data = {}

# POST リクエストを送信
response = requests.post(TARGET_URL, headers=headers, json=data, timeout=70)

# レスポンスのステータスコードと本文を表示
print("Status Code:", response.status_code)
print("Response Body:", response.text)
```

## 参考
 - [Credentials and account types/google-auth](https://googleapis.dev/python/google-auth/1.7.0/user-guide.html)
