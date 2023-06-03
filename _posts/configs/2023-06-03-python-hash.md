---
layout: post
title: "python hash"
date: 2023-06-03
excerpt: "pythonのhash関数の使い方"
config: true
tag: ["python", "hash"]
comments: false
sort_key: "2023-06-03"
update_dates: ["2023-06-03"]
---

# pythonのhash関数の使い方

## 概要
 - pythonのビルドイン関数の一つ
 - python 3.3からセキュリティの観点で、毎回ランダム化される
   - プログラム起動時に初期値`PYTHONHASHSEED`が設定されるので再現性が通常はない
   - 環境変数に`PYTHONHASHSEED=0`を与えると再現性が確保されるがセキュリティ的に脆弱になるとされている

## 具体例

### 文字列のdigest値を得る

```python
import ctypes
def myhash(word): 
    return ctypes.c_uint64(hash(word)).value.to_bytes(8,"big").hex()

aaaa = "うんち"
bbbb = "うんち"

print(myhash(aaaa), myhash(bbbb)) # f9d1cc55186b3382 f9d1cc55186b3382
```

### ユーザ定義のオブジェクトに対してhashを実行できるようにする
 - なお、`__hash__`にhashlibで実装すれば再現性が得られるものになる

```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def __hash__(self):
        return hash((self.name, self.age))
```
