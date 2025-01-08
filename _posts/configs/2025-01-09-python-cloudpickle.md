---
layout: post
title: "python cloudpickle"
date: 2025-01-09
excerpt: "python cloudpickleの使い方"
config: true
tag: ["python", "cloudpickle"]
comments: false
sort_key: "2025-01-09"
update_dates: ["2025-01-09"]
---

# python cloudpickle

## 概要
 - pickleの拡張版
 - lambda式や`__main__`で定義された関数をシリアライズ可能で別の名前空間で復元可能
   - 分散コンピューティングやクラウドコンピューティングでの利用を想定したライブラリ

## インストール

```console
$ pip install cloudpickle
```

## 使い方

**シリアライズ**

```python
# main.py
class Unchi:
    def add(self, a, b):
        return a + b

with open('data/u1.pkl', 'wb') as fp:
    fp.write(pickle.dumps(Unchi()))

with open('data/u2.pkl', 'wb') as fp:
    fp.write(cloudpickle.dumps(Unchi()))
```

**デシリアライズ**

```python
# aaa.py
import pickle

try:
    with open('data/u1.pkl', 'rb') as fp:
        u1 = pickle.load(fp)
except Exception as exc:
    print(exc) # Can't get attribute 'Unchi' on <module '__main__'>

with open('data/u2.pkl', 'rb') as fp:
    u2 = pickle.load(fp)
assert u2.add(1, 2) == 3
```
