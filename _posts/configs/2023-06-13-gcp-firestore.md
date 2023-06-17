---
layout: post
title: "gcp firestore"
date: 2023-06-13
excerpt: "gcp firestoreの使い方"
tags: ["firestore", "gcp", "api", "nosql"]
config: true
comments: false
sort_key: "2023-06-13"
update_dates: ["2023-06-13"]
---

# gcp firestoreの使い方

## 概要
 - [gcp datastore](/gcp-datastore/)の新バージョン
 - インターフェイスもアップデートされており、文法には互換がない
   - firestoreをdatastore互換モードで動作させる方法はある

## インストール

```console
$ pip install firebase-admin
```

## pythonでの具体例

**ADCでアクセス**
```console
$ gcloud auth application-default login
```

**dbにアクセス**
```python
os.environ["GOOGLE_CLOUD_PROJECT"] = "<gcp-project-id>"
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Use the application default credentials.
cred = credentials.ApplicationDefault()

firebase_admin.initialize_app(cred)
db = firestore.client()
```

**データの保存**
```python
ref = db.collection("<twitter-account>").document("<tweet-id>")
ref.set({"text": text,
        "date": date,
        "favs": favs,
        "keywords": keywords,
        "embedding": embedding})
```

**データの取得**
```python
ref = db.collection("<twitter-account>").document("<tweet-id>")
ref.get().to_dict() # dict型でデータが得られる
```

**キーの存在の判定**
```python
ref = db.collection("<twitter-account>").document("<tweet-id>")
doc = ref.get()
if doc.exists: # メンバ変数でわかる
    print("exists")
else:
    print("not exists")
```

**ソートして取得**
```python
collection_ref = db.collection('<twitter-account>')
query = collection_ref.order_by(
    'date', direction=firestore.Query.DESCENDING).limit(1000)
pd.DataFrame([doc.to_dict() for doc in query.stream()])
```

**条件を指定して取得**
```python
collection_ref = db.collection('<twitter-account>')
query = collection_ref.where("day", ">=", "2023-01-01").where("day", "<=", "2023-12-31")
pd.DataFrame([doc.to_dict() for doc in query.stream()])
```

## 参考
 - [Cloud Firestore を使ってみる/firebase.google.com](https://firebase.google.com/docs/firestore/quickstart?hl=ja)

## トラブルシューティング

### where等の操作がpythonの環境によっては動作しない
 - 原因
   - プロトコルバッファーのバージョンなどの不整合らしい
 - 対応
   - poetryなどで環境を区切ると動作する
