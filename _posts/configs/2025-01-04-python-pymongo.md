---
layout: post
title: "python pymongo"
date: 2025-01-04
excerpt: "pythonでpymongoを使う"
config: true
tag: ["python", "pymongo", "mongodb"]
comments: false
sort_key: "2025-01-04"
update_dates: ["2025-01-04"]
---

# pythonでpymongoを使う

## インストール

```console
$ pip install pymongo
```

## 使い方

```python
import pymongo
from pymongo import MongoClient
import pandas as pd

# URI
uri = "mongodb+srv://<user>:<password>@cluster0.****.mongodb.net/<database_name>?retryWrites=true&w=majority"

# MongoClientを作成
client = MongoClient(uri)

db = client["<database_name>"]

collection = db["<collection_name>"]

# ドキュメントの総数を推定
document_count = collection.estimated_document_count()
print(f"ドキュメント数: {document_count}")

def get_data():
    # クエリの条件
    query = {"host": "foo.bar.jp"}
    # ソート条件：'start_time' を降順（-1）に
    sort_order = [("start_time", pymongo.DESCENDING)]
    # 取得するドキュメント数
    limit = 500000
    # クエリの実行
    cursor = collection.find(query).sort(sort_order).limit(limit)
    # データをリストに変換
    data = list(cursor)
    return data

data = get_data()

df = pd.DataFrame(data)
```
