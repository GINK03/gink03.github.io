---
layout: post
title: "numpy squeeze"
date: 2024-01-06
excerpt: "numpy squeezeの使い方"
project: false
kaggle: true
tag: ["numpy", "python"]
comments: false
sort_key: "2024-01-06"
update_dates: ["2024-01-06"]
---

# numpy squeezeの使い方

## 概要
 - numpyのflattenと同じような働きをする
 - axisを指定することで、指定した軸を削除することができる

## サンプルコード

**基本的な使い方**

```python
import numpy as np
x = np.array([[[1], [2], [3]]])

print(x.squeeze()) # [1 2 3]

print(x.squeeze(axis=0)) # [[1] [2] [3]]
```

**要素が一つのとき、値を取り出す**

```python
import numpy as np
x = np.array([[12345]])

print(x.squeeze()[()]) # 12345
```

## 参考
 - [numpy.squeeze - numpy.org](https://numpy.org/doc/stable/reference/generated/numpy.squeeze.html#numpy-squeeze)
