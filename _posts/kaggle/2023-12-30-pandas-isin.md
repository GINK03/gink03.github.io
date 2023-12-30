---
layout: post
title: "pandas isin" 
date: 2023-12-30
excerpt: "pandasのisinの使い方"
kaggle: true
tag: ["python", "pandas", "isin", "except"]
comments: false
sort_key: "2023-12-30"
update_dates: ["2023-12-30"]
---

# pandasのisinの使い方

## 概要
 - ２つのDataFrameを比較する際に、isinを使うと便利
 - BigQueryのexceptと同じようなことができる

## ２つのDataFrameを比較し、片方にしかないレコードを抽出

```python
import pandas as pd

# サンプルデータフレームを定義
df0 = pd.DataFrame({"A": ["a", "b", "c"], "B": [1, 2, 3]})
df1 = pd.DataFrame({"A": ["b", "c"], "B": [2, 3]})

# df1の各行をタプルとして取得
df1_tuples = set(map(tuple, df1.values))

# df0の各行がdf1_tuplesに含まれないかどうかをチェックし、結果をフィルタとして適用
diff_df = df0[~df0.apply(tuple, axis=1).isin(df1_tuples)]

display(diff_df)
"""
|   | A   |   B |
|---|-----|-----|
| 0 | a   |   1 |
"""
```
