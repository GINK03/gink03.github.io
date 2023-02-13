---
layout: post
title: "pandas cut" 
date: 2023-02-13
excerpt: "pandasのcutの使い方"
kaggle: true
tag: ["python", "pandas", "cut", "チートシート"]
comments: false
sort_key: "2023-02-13"
update_dates: ["2023-02-13"]
---

# pandasのcutの使い方

## 概要
 - 連続値を整数値(カテゴリ変数)に変換する処理
 - binsで区分を設定できる
 - 引数を与えないと区間の表現を得る

## 具体例

### label情報なし

```python
import pandas as pd
import numpy as np

x = np.arange(0, 10)
display(x)
for a in pd.cut(x, bins=3):
    print(a)

"""
array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
(-0.009, 3.0]
(-0.009, 3.0]
(-0.009, 3.0]
(-0.009, 3.0]
(3.0, 6.0]
(3.0, 6.0]
(3.0, 6.0]
(6.0, 9.0]
(6.0, 9.0]
(6.0, 9.0]
"""
```

### label情報を与える

```python
x = np.arange(0, 10)
display(x)
for a in pd.cut(x, bins=3, labels=["low", "mid", "high"]):
    print(a)

"""
array([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
low
low
low
low
mid
mid
mid
high
high
high
"""
```

### Google Colab
 - [pandas-cut-example](https://colab.research.google.com/drive/1bitCOwU_GE68BM5HcjZ-jBzAKJNZIU-d?usp=sharing)

---

## 参考
 - [pandas.cut/pandas.pydata.org](https://pandas.pydata.org/docs/reference/api/pandas.cut.html)
