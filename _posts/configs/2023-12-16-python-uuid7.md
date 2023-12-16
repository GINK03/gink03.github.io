---
layout: post
title: "python uuid7"
date: 2023-12-16
excerpt: "pythonのuuid7の概要と使い方"
config: true
tag: ["python", "kvs", "uuid7"]
comments: false
sort_key: "2023-12-16"
update_dates: ["2023-12-16"]
---

# pythonのuuid7の概要と使い方

## 概要
 - 時系列順にソート可能なUUIDを生成する
 - 一般的な性質は[/UUID7/](/UUID7/)を参照

## インストール

```console
$ pip install uuid7
```

## 使い方

```python
from uuid_extensions import uuid7

print(uuid7(as_type="str")) # 0657d196-f01c-7a3c-8000-9cd52903bb31
print(uuid7(as_type="bytes")) # b'\x06W\xd1\x9d\xad\xa4y\xc3\x80\x00\xe1\x18\xa1\x93\xb9\x12'
print(uuid7(as_type="int")) # 8431349420881589067224179435970769985
```

## 参考
 - [uuid7 0.1.0](https://pypi.org/project/uuid7/)
