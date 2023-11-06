---
layout: post
title: "python fireo"
date: 2023-11-06
excerpt: "pythonのfireoの概要と使い方"
config: true
tag: ["python", "fireo", "firebase", "gcp"]
comments: false
sort_key: "2023-11-06"
update_dates: ["2023-11-06"]
---

# pythonのfireoの概要と使い方

## 概要
 - [gcpのfirestore](/gcp-firestore/)をpythonから操作するためのライブラリ(ORM)
 - firestoreのnative modeのみサポート
 - 明示的にデータベース名を指定することもできる
 - レコードのキーは `collection_name` + `id` で決定される

## インストール

```console
$ pip install fireo
```

## 使い方

### データベースの設定
 - 明示的にデータベースを指定しない場合は`(default)`が使用される

```python
import fireo
from google.cloud import firestore

fireo.connection(client=firestore.Client(database="mydb"))
```

### モデルの定義

```python
from fireo.models import Model
from fireo.fields import IDField, DateTime, TextField

class Item(Model):
    class Meta:
        collection_name = "items"
    id: str = IDField() # type: ignore
    name: str = TextField() # type: ignore
    timestamp = DateTime(auto=True) # type: ignore
```

### データの追加

```python
item = Item()
item.id = "id"
item.name = "test"
item.save()
```

### データの取得

```python
item = Item.collection.get("collection_name" + "id")
```

### データの更新

```python
item = Item.collection.get("collection_name" + "id")
item.name = "test2"
item.save(merge=True)
```

### データの削除

```python
item = Item.collection.delete("collection_name" + "id")
```

### クエリ

```python
items = Item.collection.filter("name", "==", "test").fetch()
```

## 参考
 - [fireo](https://github.com/octabytes/FireO)
