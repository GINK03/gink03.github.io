---
layout: post
title: "python difflib"
date: 2023-09-23
excerpt: "pythonのdifflibの概要と使い方"
config: true
tag: ["difflib", "python"]
comments: false
sort_key: "2023-09-23"
update_dates: ["2023-09-23"]
---

# pythonのdifflibの概要と使い方

## 概要
 - gitのdiffのようなものをpythonで行えるもの
 - デフォルトライブラリ

## 使い方

```python
import difflib

def get_diff(text1, text2):
    d = difflib.Differ()
    diff = list(d.compare(text1.splitlines(), text2.splitlines()))
    return '\n'.join(diff)

text1 = """apple
banana
cherry
date"""

text2 = """apple
berry
cherry
date
elderberry"""

print(get_diff(text1, text2))
"""
  apple
- banana
+ berry
  cherry
  date
+ elderberry
"""
```

## Google Colab
 - [python-difflib](https://colab.research.google.com/drive/1znyzCEmK2Drqsyn9DKcKDWIfIqWe1wNI#scrollTo=KZE72x0_L1K5)

## 参考
 - [difflib — Helpers for computing deltas](https://docs.python.org/3/library/difflib.html)

