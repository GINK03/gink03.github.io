---
layout: post
title: "numpy digitize"
date: 2024-07-21
excerpt: "numpy digitizeの使い方"
project: false
kaggle: true
tag: ["numpy", "python"]
comments: false
sort_key: "2024-07-21"
update_dates: ["2024-07-21"]
---

# numpy digitizeの使い方

## 概要
 - pandasのcutと同じような機能を持つ関数

## 使い方

```python
import numpy as np

# サンプルデータ
data = np.random.randn(1000)

# ビンの数を指定してビンの境界を決定
bins = 10
bin_edges = np.histogram_bin_edges(data, bins=bins)
print(bin_edges)
"""
[-3.27834551 -2.61130547 -1.94426543 -1.27722539 -0.61018535  0.05685469
  0.72389473  1.39093477  2.05797481  2.72501485  3.39205489]
"""

# 各データポイントがどのビンに属するかを決定
bin_indices = np.digitize(data, bin_edges)

# 結果の可視化
import pandas as pd
print(pd.DataFrame({"bin": bin_indices})["bin"].value_counts().to_frame()\
        .reset_index()\
        .sort_values(by=["bin"])\
        .to_markdown(index=False))
"""
|   bin |   count |
|------:|--------:|
|     1 |       6 |
|     2 |      24 |
|     3 |      82 |
|     4 |     149 |
|     5 |     225 |
|     6 |     222 |
|     7 |     169 |
|     8 |      81 |
|     9 |      35 |
|    10 |       6 |
|    11 |       1 |
"""
```
