---
layout: post
title: "python pickle"
date: "2022-12-11"
excerpt: "python pickleの使い方"
config: true
tag: ["python", "pickle"]
comments: false
sort_key: "2022-12-11"
update_dates: ["2022-12-11"]
---

# python pickleの使い方

## 概要
 - オブジェクトをシリアライズするライブラリ
   - オブジェクトで参照されている別のオブジェクトまで辿ることができるので、deep copy的なことをしている
 - dumpsの戻り値はbytes型なので、stdout/stdinをやり取りするにはbase64などでasciiに変換する必要がある

## 基本的な使用法

### オブジェクトのシリアライズ

```python
import pickle
ser = pickle.dumps([1, 2, 3])
```

### オブジェクトのデシリアライズ

```python
obj = pickle.loads(ser)
```

## シリアライズデータをasciiに変換する

```python
import pickle
import base64

def serialize(obj: Any) -> str:
    return base64.b64encode(pickle.dumps(obj)).decode()

def deserialize(ser: bytes) -> Any:
    return pickle.loads(base64.b64decode(bytes(data, "utf8")))
```

---

## 参考
 - [297. Serialize and Deserialize Binary Tree/LeetCode](https://leetcode.com/problems/serialize-and-deserialize-binary-tree/)
