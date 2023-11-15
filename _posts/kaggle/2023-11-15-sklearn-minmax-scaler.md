---
layout: post
title: "sklearn minmax-scaler"
date: 2023-11-15
excerpt: "sklearn minmax-scalerの使い方"
tags: ["python3", "sklearn", "scaler", "minmax-scaler"]
kaggle: true
comments: false
sort_key: "2023-11-15"
update_dates: ["2023-11-15"]
---

# sklearn minmax-scalerの使い方

## 概要
 - 値を0~1の範囲にスケーリングする
 - `MinMaxScaler().fit_trainsform`の引数は二次元以上の配列である必要がある

## サンプルコード

```python
from sklearn.preprocessing import MinMaxScaler 
import pandas as pd

df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6], 'C': ['a', 'b', 'c]})
df[['A', 'B']] = MinMaxScaler().fit_transform(df[['A', 'B']])
```
