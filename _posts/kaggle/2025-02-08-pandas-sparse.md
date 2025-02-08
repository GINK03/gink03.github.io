---
layout: post
title: "pandas sparse" 
date: 2025-02-08
excerpt: "pandas sparse"
kaggle: true
tag: ["pandas"]
comments: false
sort_key: "2025-02-08"
update_dates: ["2025-02-08"]
---

# pandas sparse

## 概要
 - pandasのデータ形式であってもsparse matrixを扱うことができる
 - 疎行列に変換の際、`pd.NA` などは自動で値が埋まることはない

## サンプルコード

```python
import pandas as pd

# dense な DataFrame の作成
dense_df = pd.DataFrame({
    "A": [0, 0, 1, 0],
    "B": [0.0, 0.0, 2.5, 0.0]
})

# 各列を sparse なデータ型に変換
sparse_df = dense_df.astype({
    "A": pd.SparseDtype("int", fill_value=0),
    "B": pd.SparseDtype("float", fill_value=0.0)
})
sparse_df
```

**COO(Coordinate)形式に変換**

```python
X = sparse_df.sparse.to_coo()
X
```
