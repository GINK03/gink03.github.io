---
layout: post
title: "peewee(JSON1拡張)"
date: 2023-12-28
excerpt: "python peewee(JSON1拡張)の使い方"
project: false
config: true
tag: ["database", "orm", "python", "peewee"]
comments: false
sort_key: "2023-12-28"
update_dates: ["2023-12-28"]
---

# python peewee(JSON1拡張)の使い方

## 概要
 - peeweeで`playhouse.sqlite_ext`を使うとJSON1拡張が使えるようになる

## インストール

```console
$ pip install peewee
```

## 使い方

**モデルの定義**

```python
from peewee import *
from playhouse.sqlite_ext import *

db = SqliteDatabase('my_database.db')

class Item(Model):
    name = CharField()
    data = JSONField()

    class Meta:
        database = db

db.connect()
db.create_tables([Item])

# サンプルデータの挿入
items = [
    {'name': 'Item A', 'data': {'color': 'red', 'price': 10.99, 'tags': ['new', 'hot']}},
    {'name': 'Item B', 'data': {'color': 'blue', 'price': 8.99, 'tags': ['sale', 'cool']}},
    {'name': 'Item C', 'data': {'color': 'green', 'price': 12.49, 'tags': ['eco', 'fresh']}}
]

for item in items:
    Item.create(**item)
```

**JSON1拡張を用いたクエリ**

```python
# 'color'が'red'のアイテムを検索
red_items = Item.select().where(Item.data['color'] == 'red')
for item in red_items:
    print(item.name, item.data)

# 'tags'に'eco'を含むアイテムを検索
eco_items = Item.select().where(Item.data['tags'].contains('eco'))
for item in eco_items:
    print(item.name, item.data)

# 'Item A'の価格を更新
item = Item.get(Item.name == 'Item A')
item.data['price'] = 11.99  # 価格を更新
item.save()  # 変更をデータベースに保存

# 価格が10ドル以上のアイテムを検索
expensive_items = Item.select().where(Item.data['price'] >= 10)
for item in expensive_items:
    print(item.name, item.data)
```
