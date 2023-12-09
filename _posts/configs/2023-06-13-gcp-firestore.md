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
 - nosqlデータベース
 - インターフェイスもアップデートされており、文法には互換がない
   - firestoreをdatastore互換モードで動作させる方法はある
 - 2023年に一つのプロジェクトに対して複数のデータベースが使用可能になった
   - デフォルトのデータベース名は`(default)`

## インストール

```console
$ pip install google-cloud-firestore
```

## データベースを作成する

```console
$ gcloud alpha firestore databases create \
  --database="database-name" \
  --location="asia-northeast1"
```

## エミュレータ

**Ubuntuの場合**
```console
$ sudo apt install default-jre
$ sudo apt-get install google-cloud-sdk-firestore-emulator
$ gcloud emulators firestore start # エミュレータの起動
$ export FIRESTORE_EMULATOR_HOST=[::1]:8414 # 環境変数の設定
```

## pythonでの具体例(ツイートのアカウントごとの保存)

**ADCでアクセス**
```console
$ gcloud auth application-default login
```

**dbインスタンスの初期化**
```python
from google.cloud import firestore

db = firestore.Client()
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
doc = ref.get()
if doc.exists: # ドキュメントの有無はメンバ変数でわかる
    print(f"Document data: {doc.to_dict()}")
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

**すべてのデータを取得**
```python
collection_ref = db.collection('<twitter-account>')
for doc in collection_ref.stream():
    doc.to_dict()
```

**すべてのデータを削除**
 - 原則バッチでしか削除できないのでなくなるまで実行する

```python
collection_ref = db.collection('<twitter-account>')
docs = collection_ref.list_documents(page_size=100)
for doc in docs:
    doc.delete()
```

## 参考
 - [Cloud Firestore を使ってみる/firebase.google.com](https://firebase.google.com/docs/firestore/quickstart?hl=ja)

## トラブルシューティング

### where等の操作がpythonの環境によっては動作しない
 - 原因
   - プロトコルバッファーのバージョンなどの不整合らしい
 - 対応
   - poetryなどで環境を区切ると動作する
