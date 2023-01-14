---
layout: post
title: "python dir"
date: 2023-01-14
excerpt: "pythonのdirの使い方"
tags: ["python", "python3", "dir"]
config: true
comments: false
sort_key: "2023-01-14"
update_dates: ["2023-01-14"]
---

# pythonのdirの使い方

## 概要
 - pythonのオブジェクトのアトリビュートを知るためのビルドイン関数
 - オブジェクトの設計者が明示的にdirで公開する情報を指定することもできる
 - デフォルトでは`__dict__`関数を呼ぶときの情報を元に構築する
 - 設計が未知のオブジェクトを利用するときなどに調べるのに役に立つ
   - huggung faceのトークナイザーの特殊文字の定義を調べるときなど

## オブジェクトのメンバ変数を調べる
 - `obj`はオブジェクトのインスタンス

```python
members = [member for member in dir(obj) if not callable(getattr(obj, member))]
print(members)
```

## オブジェクトの関数を調べる
 - `obj`はオブジェクトのインスタンス

```python
methods = [method for method in dir(obj) if callable(getattr(obj, method))]
print(methods)
```

## `__dir__`を定義する

```python
class Shape:
    def __dir__(self):
        return ['area', 'perimeter', 'location']

s = Shape()
print(dir(s)) # ['area', 'location', 'perimeter']
```

---

## 参考
 - [docs.python.org/3/library/functions.html](https://docs.python.org/3/library/functions.html#dir)
