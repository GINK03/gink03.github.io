---
layout: post
title: "python msgpack"
date: 2024-11-21
excerpt: "pythonでmsgpackを使う"
config: true
tag: ["python", "msgpack"]
comments: false
sort_key: "2024-11-21"
update_dates: ["2024-11-21"]
---

# pythonでmsgpackを使う

## 概要
 - msgpackを使用したデータのシリアライズ、デシリアライズについて

## インストール

```console
$ pip install msgpack
```

## シリアライズ

```python
import msgpack
import base64

data = {"name": "Alice", "age": 30, "is_member": True}

base64_encoded: str = base64.b64encode(msgpack.packb(data)).decode("utf-8")

# Base64エンコード済みの文字列を出力
print("Base64 Encoded:", base64_encoded)
"""
Base64 Encoded: g6RuYW1lpUFsaWNlo2FnZR6paXNfbWVtYmVyww==
"""
```

## デシリアライズ

```python
original_data = msgpack.unpackb(base64.b64decode(base64_encoded), raw=False)

# デコードされた元のデータを出力
print("Original Data:", original_data)
"""
Original Data: {'name': 'Alice', 'age': 30, 'is_member': True}
"""
```

