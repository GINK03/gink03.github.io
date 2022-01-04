---
layout: post
title: "pydata-google-auth"
date: "2022-01-04"
excerpt: "pydata-google-authの使い方"
project: false
config: true
tag: ["python3", "authentication", "pydata-google-auth"]
comments: false
---

# pydata-google-authのセットアップと使い方

## 概要
 - pythonでグーグル関連のユーザ認証を便利に扱うpythonのライブラリ
 - サービスアカウント情報を発行はできないが読み込みはできる
 - `pandas_gbq`など重要なライブラリが依存している

## インストール

```console
$ python3 -m pip install pydata-google-auth
```

## 使用例

### ユーザ認証情報を取得し、保存する

```python
import pydata_google_auth
from pathlib import Path


pydata_google_auth.save_user_credentials(
            scopes=["https://www.googleapis.com/auth/bigquery"],
            path=Path("~/.var/GOOGLE-USER-CRED.json").expanduser(),
            use_local_webserver=False
        )
```
 - `scopes`; 権限を許可するスコープをリストで入力
   - [scope一覧](https://developers.google.com/identity/protocols/oauth2/scopes)
 - `path`; 取得した認証情報を保存するパス
 - `use_local_webserver`; ローカルでブラウザを立ち上げるかどうか(リモートのterminal時はFalse)

### 保存した認証情報をロードしてcredentialを得る

```python
import pydata_google_auth
from pathlib import Path

credentials = pydata_google_auth.load_user_credentials(
    Path("~/.var/GOOGLE-USER-CRED.json").expanduser()
)
```

### もらった or 発行したサービスアカウント情報をロードしてcredential情報を得る

```python
import pydata_google_auth
from pathlib import Path


credentials = pydata_google_auth.load_service_account_credentials(
    Path("~/.var/keys/google-service-account-credentials.json").expanduser(),
)
```

## 参考
 - [API Reference@pydata-google-auth.readthedocs.io](https://pydata-google-auth.readthedocs.io/en/latest/api.html#pydata_google_auth.save_user_credentials)
