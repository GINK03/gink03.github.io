---
layout: post
title: "列挙型"
date: 2021-02-20
excerpt: "列挙型について"
computer_science: true
hide_from_post: true
tag: ["enum", "列挙型"]
comments: false
---

# 列挙型について

## 概要
 - 明示的にマジックナンバーを利用するよりも役に立つ
 - 人間が誤って算術演算を行ってしまうようなエラーから防ぐ

## pythonによる例

```python
from enum import Enum, auto

class State(Enum):
    S1 = auto()
    S2 = auto()
    S3 = auto()

print(State.S1, State.S2, State.S3)
print(State.S1.value, State.S2.value, State.S3.value

>> State.S1 State.S2 State.S3
>> 1 2 3
```

## colabでの例
 - [link](https://colab.research.google.com/drive/1cg37cDuY9zc58SU-UQ_H8Li00Pj9Ky_c?usp=sharing)
