---
layout: post
title: "polynomial"
date: 2021-08-05
excerpt: "ポリノミアルで特徴量作成"
kaggle: true
hide_from_post: true
tag: ["sklearn", "python", "polynomial", "feature"]
comments: false
---

# ポリノミアルで特徴量作成
 - [公式](https://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.PolynomialFeatures.html)

## 概要
 - `[a, b]`の入力があるときに、`[1、a、b、a ^ 2、ab、b ^ 2]`を作る機能

## サンプル

```python
>>> import pandas as pd
>>> import numpy as np
>>> from sklearn.preprocessing import PolynomialFeatures
>>> df = pd.DataFrame({"a": [1,2,3]})
>>> df
   a
0  1
1  2
2  3
>>> np.array(df[['a']])
array([[1],
       [2],
       [3]])
>>> np.array(df[['a']]).reshape(-1,1)
array([[1],
       [2],
       [3]])
>>> poly = PolynomialFeatures(degree=3)
>>> poly.fit_transform(df[['a']])
array([[ 1.,  1.,  1.,  1.],
       [ 1.,  2.,  4.,  8.],
       [ 1.,  3.,  9., 27.]])
```

