---
layout: post
title: "pydantic"
date: "2022-05-12"
excerpt: "pydanticの使い方"
project: false
config: true
tag: ["python", "pydantic", "type safe"]
comments: false
sort_key: "2022-05-12"
update_dates: ["2022-05-12"]
---

# pydanticの使い方　

## 概要
 - pythonのdataclassより簡単でwell managedなdataclass関連を提供するライブラリ
 - `.dict()`, `.json()`メソッドを使うことで、dict形式やjson形式への変換が可能

## インストール

```console
$ python3 -m pip install pydantic
```

## 具体例と特徴
 - 指定した型への変換がエラー無しで行えるときは行う
 - 指定した型と異なる場合(e.g. 文字 -> 数値)、わかりやすい例外を送出する
 - json形式へのserializeをサポートする

```python
from pydantic import BaseModel
import pydantic

class User(BaseModel):
    id: int
    weight: float = 55.4
    name = 'Jane Doe'

user = User(id="123") # 数値に自動的なキャスト可能な値ならOK
print(user)
assert user.id == 123, "数値に自動的にキャストされる"

# dict形式でのデータの取得
print(user.dict())
# データのシリアライズ
print(user.json())

try:
    user2 = User(id="2ab", name=123) # "2ab"は数値に変換できないのでエラーが出る
except pydantic.error_wrappers.ValidationError as ex:
    print(ex.json())

user3 = User(id="234", weight=999, name=123) # int <-> floatはok, 123 <-> "123"に変換可能なのでok

print(user3.json())
```

## 参考
 - [pydantic-docs.helpmanual.io](https://pydantic-docs.helpmanual.io)
