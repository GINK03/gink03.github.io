---
layout: post
title: "gcp datastore"
date: "2022-09-23"
excerpt: "gcp datastoreの使い方"
config: true
tag: ["gcp", "gcloud", "datastore", "nosql"]
comments: false
sort_key: "2022-08-12"
update_dates: ["2022-08-12"]
---

# gcp datastoreの使い方

## 概要
 - GCP上で動作するマネージドのnosql
 - pythonのdict型のようなデータを保持する
 - local emulatorがある
 - firestoreという次世代のnosqlもある(若干使い方が異なる, local emulatorのセットアップが異なる)

## ローカルエミュレータの使用法

### エミュレータのインストール
```console
$ gcloud components install cloud-datastore-emulator
```

### ローカルエミュレータの起動
```console
$ gcloud beta emulators datastore start
```

### エミュレータを動作させるための環境変数のロード
```console
$ $(gcloud beta emulators datastore env-init)
```

## 具体例

**公式の例**
```python
from google.cloud import datastore
import datetime

datastore_client = datastore.Client()
kind = "Task"
name = "sampletask1"
task_key = datastore_client.key(kind, name) # キーを取得
task = datastore.Entity(key=task_key)
task["description"] = "Buy milk" # dict型でデータを挿入できる
datastore_client.put(task) # 保存
print(f"Saved {task.key.name}: {task['description']}")
```

**一括でデータを入れる**
```python
""" データを入れる例 """
key = datastore_client.key('users', '213')
task = datastore.Entity(key)
task.update({
    'name': 'Bob',
    'transaction_id': 1878,
    'timestamp': [datetime.datetime.now()],
    'revenue': [135.55, 222],
    'paid': True
})
datastore_client.put(task)
```

**すべてのデータを取り出す例**
```python
datastore_client = datastore.Client()
docs = datastore_client.query(kind='users').fetch()
for doc in docs:
    print(doc.key.name)
    print(doc)
```

**存在しないキーを参照したとき**
```python
""" 存在しないキーの例 """
datastore_client = datastore.Client()
key = datastore_client.key('users', '0000')
task = datastore.Entity(key)
assert(task == {})
```

**特定の値を検索**
```python
""" 特定の条件に一致する結果を取り出す例 """
datastore_client = datastore.Client()
docs = datastore_client.query(kind='users').add_filter('paid', '=', True).fetch()
for doc in docs:
    print(doc.key.name)
    print(doc)
```

---

## 参考
 - [Datastore エミュレータの実行](https://cloud.google.com/datastore/docs/tools/datastore-emulator?hl=ja)
