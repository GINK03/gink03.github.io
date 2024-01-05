---
layout: post
title: "peewee"
date: 2023-12-28
excerpt: "python peeweeの使い方"
project: false
config: true
tag: ["database", "orm", "python", "peewee"]
comments: false
sort_key: "2023-12-28"
update_dates: ["2023-12-28"]
---

# python peeweeの使い方

## 概要
 - pythonでORMを使うためのライブラリ
 - 使い方はSQLAlchemyとほぼ同じ(より簡単)
 - sqliteのJSON1拡張を使うことができる
 
## インストール

```console
$ pip install peewee
```

## 使い方

**モデルの定義**

```python
from peewee import *

db = SqliteDatabase('my_database.db')

class User(Model):
    username = CharField(unique=True)
    password = CharField(null=True)
    timestamp = DateTimeField(default=datetime.datetime.now)
    email = CharField(null=True)

    class Meta:
        database = db  # このモデルが使用するデータベース

class Tweet(Model):
    user = ForeignKeyField(User, backref='tweets')  # Userモデルへの外部キー
    message = TextField()

    class Meta:
        database = db

db.connect()
db.create_tables([User, Tweet])
```

**モデルの操作**

```python
# ユーザの作成
user1 = User.create(username='user1', password='pass123', email='user1@example.com')
user2 = User.create(username='user2', password='pass123', email='user2@example.com')
# ユーザの取得と更新(get)
user = User.get(User.username == 'user1') # getは一致するものがないと例外を投げる
# ユーザの取得と更新(get_or_none)
user = User.get_or_none(User.username == 'user1') # get_or_noneは一致するものがないとNoneを返す
user.username = 'new_username'
user.save()
# ユーザの削除
user.delete_instance()
# すべてのデータを取得
for user in User.select():
    print(user.username) # user1, user2
# tweetデータを作成して検索
tweet = Tweet.create(user=user2, message='This is a tweet')
tweets = Tweet.select().where(Tweet.user == user2)
for tweet in tweets:
    print(tweet.message)
```

### 大量のデータを取得する
 - `iterator()`を使うと一件ずつ取得することができる

```python
for tweet in Tweet.select().order_by(Tweet.id).iterator():
    print(tweet.message)
```

