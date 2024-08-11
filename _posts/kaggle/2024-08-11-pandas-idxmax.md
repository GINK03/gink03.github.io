---
layout: post
title: "pandas idxmax" 
date: 2024-08-11
excerpt: "pandasのidxmaxの使い方"
kaggle: true
tag: ["python", "pandas", "idxmax", "チートシート"]
comments: false
sort_key: "2024-08-11"
update_dates: ["2024-08-11"]
---

# pandasのidxmaxの使い方

## 概要
 - pandasの`idxmax`関数は、最大値を持つ行・列のインデックスを取得する関数
   - 列の場合は、インデックスがカラム名になる

## サンプルコード

```python
import pandas as pd

# サンプルデータフレームを作成
data = {
    'A': [1, 3, 5, 8],
    'B': [2, 9, 6, 7],
    'C': [9, 7, 5, 3]
}
df = pd.DataFrame(data)

# 列ごとに最大値を持つインデックスを取得
column_idxmax = df.idxmax()
"""
|    |   0 |
|:---|----:|
| A  |   3 |
| B  |   1 |
| C  |   0 |
"""

# 行ごとに最大値を持つインデックスを取得
row_idxmax = df.idxmax(axis=1)
"""
|    | 0   |
|---:|:----|
|  0 | C   |
|  1 | B   |
|  2 | B   |
|  3 | A   |
"""
```
