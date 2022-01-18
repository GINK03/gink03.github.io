---
layout: post
title: "pydata-google-auth"
date: "2022-01-18"
excerpt: "pydata-google-authの使い方"
project: false
config: true
tag: ["python3", "pandas-gbq", "google-auth"]
comments: false
---

# pydata-google-authの使い方

## 概要
 - Pythonでgoogle関連のサービスにアクセスする際に必要な認証を便利に行ってくれるライブラリ
 - 認証情報をキャッシュしたりできる

## インストール

```console
$ python3 -m pip install pydata-google-auth
```

## 具体例

```python
cred_path = Path("~/.var/temporary-cred.json").expanduser()
if not cred_path.exists():
    pydata_google_auth.save_user_credentials(
        ["https://www.googleapis.com/auth/bigquery"],
        cred_path,
        use_local_webserver=True,
    )
credentials = pydata_google_auth.load_user_credentials(cred_path)
```
 - 特定のパスにクレデンシャルがなかったら認証を行い、保存する

## [GoogleAPIのOAuth2.0スコープ](https://developers.google.com/identity/protocols/oauth2/scopes)
