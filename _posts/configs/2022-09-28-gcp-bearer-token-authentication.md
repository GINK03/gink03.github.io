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

## 具体例(デフォルトのサービスアカウントでトークンを生成する)

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

## 具体例(サービスアカウントのクレデンシャルファイルでvertex AIにローカルPCから接続する)

```python
import google.auth
import google.auth.transport.requests
from google.oauth2 import service_account
    
ENDPOINT_ID="<endpoint_id>"
PROJECT_ID="<project_id>"

def make_authorized_get_request(obj: List[List[str]]):
    credentials = service_account.Credentials.from_service_account_file(
        "/Users/<username>/.var/GOOGLE_APPLICATION_CREDENTIALS_VERTEX_AI.json",
        scopes=['https://www.googleapis.com/auth/cloud-platform'] # scopes
    )
    auth_req = google.auth.transport.requests.Request()
    credentials.refresh(auth_req)
    access_token = credentials.token
    headers = {
        "Authorization": f"Bearer {access_token}",
        "Content-type": "application/json"
    }
    url = f"https://us-central1-aiplatform.googleapis.com/v1/projects/{PROJECT_ID}/locations/us-central1/endpoints/{ENDPOINT_ID}:predict"
    with requests.post(url=url, headers=headers, json=obj) as r:
        ret = r.text
    return json.loads(ret)
```

---

## 参考
 - [Credentials and account types/google-auth](https://googleapis.dev/python/google-auth/1.7.0/user-guide.html)
