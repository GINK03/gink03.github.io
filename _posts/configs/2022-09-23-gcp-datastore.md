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

---

## 具体例

**公式の例(エンティティを新規に追加する)**
```python
from google.cloud import datastore
import datetime

client = datastore.Client()
kind = "Task"
name = "sampletask1"
task_key = client.key(kind, name) # キーを取得
task = datastore.Entity(key=task_key)
task["description"] = "Buy milk" # dict型でデータを挿入できる
client.put(task) # 保存
print(f"Saved {task.key.name}: {task['description']}")
```

**一括でデータを入れ、エンティティを追加する**
```python
""" データを入れる例 """
key = client.key('users', '213')
task = datastore.Entity(key)
task.update({
    'name': 'Bob',
    'transaction_id': 1878,
    'timestamp': [datetime.datetime.now()],
    'revenue': [135.55, 222],
    'paid': True
})
client.put(task)
```

**すべてのデータを取り出す例**
```python
client = datastore.Client()
docs = client.query(kind='users').fetch()
for doc in docs:
    print(doc.key.name)
    print(doc)
```

**存在しないキーを参照したとき**
```python
""" 存在しないキーの例 """
client = datastore.Client()
key = client.key('users', '0000')
task = datastore.Entity(key)
assert(task == {})
```

**特定の値を検索**
```python
""" 特定の条件に一致する結果を取り出す例 """
client = datastore.Client()
docs = client.query(kind='users').add_filter('paid', '=', True).fetch()
for doc in docs:
    print(doc.key.name)
    print(doc)
```

**特定のキーのエンティティを取り出す**
```python
client = datastore.Client()
with client.transaction():
    key = client.key("users", user)
    if task := client.get(key):
        logger.info(task)
```

---

## 値があるかどうかを検索し、なければエンティティを追加、あれば値を更新

```python
from google.cloud import datastore
import datetime
import numpy as np
from loguru import logger
from tqdm.auto import tqdm
client = datastore.Client()

def update_data(user: str):
    with client.transaction():
        key = client.key("users", user)
        if task := client.get(key):
            # logger.info(task)
            task["datetimes"].append(datetime.datetime.now())
            while len(task["datetimes"]) > 3:
                task["datetimes"].pop(0)
            client.put(task)
        else:
            task = datastore.Entity(key=key)
            task.update({
                'name': key,
                'datetimes': [datetime.datetime.now()]
            })
            client.put(task)

for _ in tqdm(range(10**5)):
    chrs = np.random.choice(list("1234567890"), size=3, replace=True)
    update_data(user="".join(chrs))
```

---

## 参考
 - [Datastore エミュレータの実行/GoogleCloud](https://cloud.google.com/datastore/docs/tools/datastore-emulator?hl=ja)
 - [更新/GoogleCloud](https://cloud.google.com/datastore/docs/samples/datastore-update)
