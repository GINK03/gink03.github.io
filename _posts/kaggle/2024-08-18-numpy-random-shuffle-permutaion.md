---
layout: post
title: "numpy random shuffleとpermutationの使い方"
date: 2024-08-18
excerpt: "numpy random shuffleとpermutationの使い方"
project: false
kaggle: true
tag: ["numpy", "python"]
comments: false
sort_key: "2024-08-18"
update_dates: ["2024-08-18"]
---

# numpy random shuffleとpermutationの使い方

## 概要
 - `shuffle`と`permutation`は、配列をランダムに並び替える関数
   - `shuffle`は、元の配列を直接変更する
   - `permutation`は、元の配列を変更せず、新しい配列を返す

## 具体例

```python
import numpy as np

arr = np.array([[1,2], [3,4], [5,6]])

ret = np.random.permutation(arr)
print(ret)
"""
[[3 4]
 [1 2]
 [5 6]]
"""

np.random.shuffle(arr)
print(arr)
"""
[[3 4]
 [1 2]
 [5 6]]
"""
```
