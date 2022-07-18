---
layout: post
title: "Python OrderedDict"
date: "2022-07-18"
excerpt: "Python OrderedDictの使い方"
config: true
tag: ["python", "ordereddict"]
comments: false
sort_key: "2022-07-18"
update_dates: ["2022-07-18"]
---

# Python OrderedDictの使い方

## 概要
 - C++のsetのように二分木のような構造で実装されたdict
 - 順序を保存する
 - 最初と最後の要素のアクセスが\\(lon(n)\\)
 - 任意のキーを最初、最後に移動することができる
 - 長さがわかり、古いものを削除できる特性からLRUを実装することもできる

## 実装例

```python
from collections import OrderedDict

dic = OrderedDict()
dic[3] = "a"
dic[2] = "b"
dic[1] = "c"
assert dic == OrderedDict([(3, 'a'), (2, 'b'), (1, 'c')])

# popitemで最初 or 最後の要素を消せる
# last=Falseで最初の要素を消す
dic.popitem(last=False)
assert dic == OrderedDict([(2, 'b'), (1, 'c')])
# last=Trueで最後の要素を消す
dic.popitem(last=True)
assert dic == OrderedDict([(2, 'b')])


dic = OrderedDict()
dic[3] = "a"
dic[2] = "b"
dic[1] = "c"

# 特定のキーを最後 or 最初にもってくる
# 3のキーを最後に
dic.move_to_end(3)
print(dic) # OrderedDict([(2, 'b'), (1, 'c'), (3, 'a')])
# 1のキーを最初に
dic.move_to_end(1, last=False)
print(dic) # OrderedDict([(1, 'c'), (2, 'b'), (3, 'a')])
```

## 参考
 - [OrderedDict オブジェクト](https://docs.python.org/ja/3/library/collections.html?highlight=ordereddict#collections.OrderedDict)

