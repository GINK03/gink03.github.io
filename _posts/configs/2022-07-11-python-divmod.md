---
layout: post
title: "python divmod" 
date: "2022-07-11"
excerpt: "python divmodの使い方"
config: true
tag: ["python", "divmod"]
comments: false
sort_key: "2022-07-11"
update_dates: ["2022-07-11"]
---

# python divmodの使い方

## 概要
 - ビルドイン関数の一つ
 - たまにしか現れない
 - 商と余りをtupleで返す関数

## 具体例

```python
def my_divmod(a, b):
    return (a//b, a%b)

import random
lst = list(range(1, 10**6))
for i in range(10**5):
    a, b = random.choice(lst), random.choice(lst)
    assert divmod(a, b) == my_divmod(a, b)
```

## 参考
 - [Python divmod()](https://www.programiz.com/python-programming/methods/built-in/divmod)
