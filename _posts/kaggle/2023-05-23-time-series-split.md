---
layout: post
title: "time series split"
date: 2023-05-23
excerpt: "time series splitについて"
tags: ["統計", "外挿", "time series split"]
kaggle: true
comments: false
sort_key: "2023-05-23"
update_dates: ["2023-05-23"]
---

# time series splitについて

## 概要
 - 時系列データで外挿に対してロバストなモデルを作成する際に必要な方法
 - 時系列をkfoldするイメージであるが、モデルを作成するのには利用せず、パラメータを求めるのに利用するイメージ
   - 常に最新のデータがvalidationになり、trainデータがだいぶ可変になる
 - モデルを作成する際には、最適なパラメータが判明した後、すべてのデータを入れて学習する

## python + sklearnでの例

```python
import numpy as np
from sklearn.model_selection import TimeSeriesSplit

X = np.array([[1, 2], [3, 4], [1, 2], [3, 4], [1, 2], [3, 4]])
y = np.array([1, 2, 3, 4, 5, 6])

tscv = TimeSeriesSplit()

for i, (train_index, test_index) in enumerate(tscv.split(X)):
    print(f"Fold {i}:")
    print(f"  Train: index={train_index}")
    print(f"  Test:  index={test_index}")

"""
Fold 0:
  Train: index=[0]
  Test:  index=[1]
Fold 1:
  Train: index=[0 1]
  Test:  index=[2]
Fold 2:
  Train: index=[0 1 2]
  Test:  index=[3]
Fold 3:
  Train: index=[0 1 2 3]
  Test:  index=[4]
Fold 4:
  Train: index=[0 1 2 3 4]
  Test:  index=[5]
"""
```

### Google Colab
 - [time-series-split-exapmple](https://colab.research.google.com/drive/1qq6ILL9ALdh5el7beTqzLYzdB2UhHN0y?usp=sharing)

## 参考
 - [sklearn.model_selection.TimeSeriesSplit/scikit-learn.org](https://scikit-learn.org/stable/modules/generated/sklearn.model_selection.TimeSeriesSplit.html)
 - [交差検証（Python実装）を徹底解説！図解・サンプル実装コードあり](https://www.codexa.net/cross_validation/)
   - `時系列交差検証（Time Series Split）`の項目を参照

