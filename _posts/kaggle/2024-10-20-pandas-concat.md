---
layout: post
title: "pandas concat" 
date: 2024-10-20
excerpt: "pandas concatの使い方"
kaggle: true
tag: ["pandas"]
comments: false
sort_key: "2024-10-20"
update_dates: ["2024-10-20"]
---

# pandas concat

## 概要
 - `pd.concat` は、複数のデータフレームを結合する関数
 - 結合方法は、`axis` で指定
   - `axis=0` は縦結合
   - `axis=1` は横結合
 - index が重複している場合、`ignore_index=True` で新しい index を付与できる
 - マルチレベル index を付与する場合、`keys` で指定

## 使用例

```python
import pandas as pd

df0 = pd.DataFrame()
df0["会社名"] = ["a", "b", "c"]
df0["売上"] = [100, 200, 150]
df0 = df0.reset_index(drop=True)

df1 = pd.DataFrame()
df1["会社名"] = ["A", "B", "C"]
df1["売上"] = [200, 300, 250]
df1 = df1.reset_index(drop=True)

# 縦結合
pd.concat([df0, df1])
"""
|    | 会社名   |   売上 |
|---:|:---------|-------:|
|  0 | a        |    100 |
|  1 | b        |    200 |
|  2 | c        |    150 |
|  0 | A        |    200 |
|  1 | B        |    300 |
|  2 | C        |    250 |
"""

# 縦結合(新しい index を付与)
pd.concat([df0, df1], ignore_index=True)
"""
|    | 会社名   |   売上 |
|---:|:---------|-------:|
|  0 | a        |    100 |
|  1 | b        |    200 |
|  2 | c        |    150 |
|  3 | A        |    200 |
|  4 | B        |    300 |
|  5 | C        |    250 |
"""

# 横結合
pd.concat([df0, df1], axis=1)
"""
|    | 会社名   |   売上 | 会社名   |   売上 |
|---:|:---------|-------:|:---------|-------:|
|  0 | a        |    100 | A        |    200 |
|  1 | b        |    200 | B        |    300 |
|  2 | c        |    150 | C        |    250 |
"""

# 横結合(マルチレベル index)
pd.concat([df0, df1], axis=1, keys=["JP", "US"])
"""
|    | JP                 | US                 |
|    | 会社名   |    売上 | 会社名   |    売上 |
|---:|:---------|--------:|:---------|--------:|
|  0 | a        |     100 | A        |     200 |
|  1 | b        |     200 | B        |     300 |
|  2 | c        |     150 | C        |     250 |
"""
```
