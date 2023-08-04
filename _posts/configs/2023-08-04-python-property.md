---
layout: post
title: "python property"
date: "2023-08-04"
excerpt: "pythonのpropertyの使い方"
project: false
config: true
tag: ["python", "property"]
comments: false
sort_key: "2023-08-04"
update_dates: ["2023-08-04"]
---

# pythonのpropertyの使い方

## 概要
 - オブジェクト指向のプロパティ(メンバ変数の呼び出しや値の代入)を関数でラップすることでより安全に扱うもの

## 具体例

```python
class Person:
    def __init__(self, name):
        self._name = name

    @property
    def name(self):
        return self._name

    @name.setter
    def name(self, value):
        if not isinstance(value, str):
            raise TypeError("名前は文字列でなければなりません")
        self._name = value

person = Person("Alice")
print(person.name)  # Alice
person.name = "Bob"
print(person.name)  # Bob
```

### Google Colab
 - [python-property-example](https://colab.research.google.com/drive/1X5f21fXMTxm0IANk27E-H29M4BsOIjkE?usp=sharing)

## 参考
 - [Built-in Functions#property](https://docs.python.org/3/library/functions.html#property)
