---
layout: post
title: "standard scale(標準化, スタンダライゼーション)"
date: 2022-09-16
excerpt: "standard scale(標準化, スタンダライゼーション)の計算"
kaggle: true
tag: ["python", "標準化", "standard scale"]
sort_key: "2022-09-17"
update_dates: ["2022-09-17"]
comments: false
---

# standard scale(標準化, スタンダライゼーション)の計算

## 概要
 - データを同じような大きさの空間に組み込むとき
 - 区間は`0 ~ 1`に限定されない

## 定式

$$
z = \frac{x - \mu}{s}
$$

 - \\(\mu\\); 平均値
 - \\(s\\); 標準偏差

## numpyでの利用法

```python
x = (x - np.mean(x))/np.std(x)
```

## sklearnでの使用法

```python
from sklearn.preprocessing import StandardScaler
data = [[0, 0], [0, 0], [1, 1], [1, 1]]
scaler = StandardScaler()
scaler.fit(data)

print(scaler.transform(data))
"""
[[-1. -1.]
 [-1. -1.]
 [ 1.  1.]
 [ 1.  1.]]
"""
```

---

## 参考
 - [sklearn.preprocessing.StandardScaler/sklearn](https://scikit-learn.org/stable/modules/generated/sklearn.preprocessing.StandardScaler.html) 
 - [Numpy:zero mean data and standardization](https://stackoverflow.com/questions/45834276/numpyzero-mean-data-and-standardization)
