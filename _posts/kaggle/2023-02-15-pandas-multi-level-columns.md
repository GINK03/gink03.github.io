---
layout: post
title: "pandas multi level columns" 
date: 2023-02-16
excerpt: "pandasのmulti level columnsの使い方"
kaggle: true
tag: ["python", "pandas", "multi level columns", "チートシート"]
comments: false
sort_key: "2023-02-16"
update_dates: ["2023-02-16"]
---

# pandasのmulti level columnsの使い方

## 概要
 - aggregateした場合、`transpose` した場合などにカラム名がmulti levelになることがある
 - multi level columnsはタプルを指定することで列にアクセスできる
 - `get_level_values` を使うことで、特定のレベルの値を取得できる

## 具体例

**マルチレベルカラムの作成**
```python
import pandas as pd

df = pd.DataFrame([[1, 2, 3, 4], [5, 6, 7, 8]], 
                  columns=[['A', 'A', 'B', 'B'], ['a', 'b', 'c', 'd']])
display(df)
"""
|    |   ('A', 'a') |   ('A', 'b') |   ('B', 'c') |   ('B', 'd') |
|---:|-------------:|-------------:|-------------:|-------------:|
|  0 |            1 |            2 |            3 |            4 |
|  1 |            5 |            6 |            7 |            8 |
"""
```

**レベル1のカラムを取得**
```python
df.columns = df.columns.get_level_values(1)
display(df)
"""
|    |   a |   b |   c |   d |
|---:|----:|----:|----:|----:|
|  0 |   1 |   2 |   3 |   4 |
|  1 |   5 |   6 |   7 |   8 |
"""
```

### Google Colab
 - [pandas-multilevel-columns](https://colab.research.google.com/drive/1nrHLZ_djmEZpuqBCD8nbnz-wUeJiP2KP?usp=sharing)

## 参考
 - [Pandas: Multilevel column names/stackoverflow](https://stackoverflow.com/questions/21443963/pandas-multilevel-column-names)
