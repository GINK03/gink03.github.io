---
layout: post
title: "python redis"
date: 2024-07-07
excerpt: "python redisの使い方"
tags: ["redis", "elastic-cache", "docker", "python", "valkey"]
config: true
comments: false
sort_key: "2024-07-07"
update_dates: ["2024-07-07"]
---

# python redisの使い方

## 概要
 - redisまたはvalkeyのpythonクライアント
 - ほぼ同じ機能の名前の`valkey`というパッケージのクライアントが存在する

## インストール

**python**
```console
$ pip install redis # redis
$ pip install valkey # valkey
```


## 使用例

**基本的な使い方**
```python
import redis

client = redis.Redis(host='localhost', port=6379, decode_responses=True, ssl=False, username=None, password=None)
# client = valkey.ValKey(host='localhost', port=6379, decode_responses=True, ssl=False, username=None, password=None) # valkeyの使用例

client.flushdb() # DBをすべてクリア ref. https://stackoverflow.com/questions/45916183/how-do-i-to-flush-redis-db-from-python-redis

# set, get
client.set('foo', 'bar')
print(client.get('foo')) # bar

# keyの存在確認
print(client.exists('foo')) # True

# keyの削除
client.delete('foo')
```

**ハッシュ**
```python
# ハッシュキーとフィールドの設定
hash_key = "user:1"
fields = {
    "name": "John Doe",
    "email": "johndoe@example.com",
    "age": 30
}

# ハッシュにフィールドを追加
client.hmset(hash_key, fields)

# 全てのフィールドと値を取得
all_fields = client.hgetall(hash_key)
for field, value in all_fields.items():
    print(f"{field.decode('utf-8')}: {value.decode('utf-8')}")
"""
name: John Doe
email: johndoe@example.com
age: 30
"""

# 複数のフィールドを取得
fields_to_get = ["name", "email"]
values = client.hmget(hash_key, fields_to_get)
print(f"Values: {[value.decode('utf-8') for value in values]}")  # 出力: Values: ['John Doe', 'johndoe@example.com']

# 特定のフィールドを削除
client.hdel(hash_key, "age")

# 特定のフィールドの存在確認
exists = client.hexists(hash_key, "age")
print(f"Age field exists: {exists}")  # 出力: Age field exists: False
```

**redisのexpire設定**
 - キーの寿命を設定する
   - セッション管理
   - 広告などの頻度コントロール
 - `ex`の指定時間単位は秒

```python
client.set('foo', 'bar', ex=60)
# or
client.expire('foo', ex=60)
```

**特定のprefixのデータを消す**

```python
REDIS_PREFIX = "A_NAMESPACE"
for key in client.scan_iter(f"{REDIS_PREFIX}:*"):
    client.delete(key)
```

