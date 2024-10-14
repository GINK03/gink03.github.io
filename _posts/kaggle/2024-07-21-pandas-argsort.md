---
layout: post
title: "pandas argsort"
date: 2024-7-21
excerpt: "pandas argsort"
project: false
kaggle: true
hide_from_post: true
tag: ["python", "pandas", "チートシート"]
comments: false
sort_key: "2024-07-21"
update_dates: ["2024-07-21"]
---

# pandas argsort

## 概要
 - pandasのargsortはdataframeのindexのseriesを返す
 - pandasのseriesを引数にnp.argsortを適応することでpd.Series.argsortと同じ結果を得ることができる

## 具体例

```python
import pandas as pd

# サンプルデータフレーム
df = pd.DataFrame({
    'name': ['Alice', 'Bob', 'Charlie'],
    'age': [35, 30, 20],
    'city': ['Tokyo', 'Osaka', 'Nagoya']
})

# name 列をインデックスに設定
df = df.set_index('name')

# 'age' 列に対して argsort を適用
sorted_indices = df['age'].argsort()
print(sorted_indices)
"""
name
Alice      2
Bob        1
Charlie    0
Name: age, dtype: int64
"""

# numpy の argsort を利用しても同じ結果が得られる
sorted_indices_numpy = np.argsort(df['age'])
print(sorted_indices_numpy)
"""
name
Alice      2
Bob        1
Charlie    0
Name: age, dtype: int64
"""

# インデックスを利用してデータフレームをソート
df = df.iloc[sorted_indices]
"""
| name    |   age | city   |
|:--------|------:|:-------|
| Charlie |    20 | Nagoya |
| Bob     |    30 | Osaka  |
| Alice   |    35 | Tokyo  |
"""
```
