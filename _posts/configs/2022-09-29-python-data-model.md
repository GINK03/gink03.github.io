---
layout: post
title: "python data model" 
date: "2022-09-29"
excerpt: "python data modelの使い方"
config: true
tag: ["platform", "python"]
comments: false
sort_key: "2022-09-29"
update_dates: ["2022-09-29"]
---

# python data modelの使い方

## 概要
 - クラスの`__init__`, `__str__`, `__len__`などこと

## ユーザ定義のクラスをprintしたときにhuman readableにする

```python
class A:
  def __init__(self):
    self.a = 10
    self.b = "foo"
  def __str__(self):
    return f'a = {self.a}, b = {self.b}'
```

---

## 参考
 - [3. Data mode/python.org](https://docs.python.org/3/reference/datamodel.html#object.__str__)
