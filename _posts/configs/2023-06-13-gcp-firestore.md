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
 - 操作に失敗した場合には、リトライが可能
 - embeddingデータなど大量のデータを保存する場合は、シリアライズして保存するほうが良い

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
$ gcloud emulators firestore start --host-port=0.0.0.0:8414 # ポートを指定して起動
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
from google.api_core.retry import Retry, if_exception_type
from google.api_core.exceptions import Aborted

client = firestore.Client(project="project-id", database="database-name")
```

**データの保存**
```python
# リトライポリシーの設定
retry_policy = Retry(predicate=if_exception_type(Aborted))

ref = client.collection("<twitter-account>").document("<tweet-id>")
ref.set({"text": text,
        "date": date,
        "favs": favs,
        "keywords": keywords,
        "embedding": embedding},
        retry=retry_policy)
```

**データの取得**
```python
ref = client.collection("<twitter-account>").document("<tweet-id>")
doc = ref.get()
if doc.exists: # ドキュメントの有無はメンバ変数でわかる
    print(f"Document data: {doc.to_dict()}")
else:
    print("not exists")
```

**ソートして取得**
```python
collection_ref = client.collection('<twitter-account>')
query = collection_ref.order_by(
    'date', direction=firestore.Query.DESCENDING).limit(1000)
pd.DataFrame([doc.to_dict() for doc in query.stream()])
```

**条件を指定して取得**
```python
collection_ref = client.collection('<twitter-account>')
query = collection_ref.where("day", ">=", "2023-01-01").where("day", "<=", "2023-12-31")
pd.DataFrame([doc.to_dict() for doc in query.stream()])
```

**すべてのデータを取得**
```python
collection_ref = client.collection('<twitter-account>')
for doc in collection_ref.stream():
    print(f"{doc.id} => {doc.to_dict()}")
```

**すべてのデータを削除**
```python
collection_ref = client.collection('<twitter-account>')
for doc in collection_ref.stream(retry=Retry()):
    doc.reference.delete()
```

## 参考
 - [Cloud Firestore を使ってみる/firebase.google.com](https://firebase.google.com/docs/firestore/quickstart?hl=ja)

## トラブルシューティング

### where等の操作がpythonの環境によっては動作しない
 - 原因
   - プロトコルバッファーのバージョンなどの不整合らしい
 - 対応
   - poetryなどで環境を区切ると動作する
