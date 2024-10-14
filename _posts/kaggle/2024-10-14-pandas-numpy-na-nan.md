---
layout: post
title: "pandas numpyのna, nanの使い方" 
date: 2024-10-14
excerpt: "pandas numpyのna, nanの使い方について"
kaggle: true
tag: ["pandas", "numpy", "na", "nan"]
comments: false
sort_key: "2024-10-14"
update_dates: ["2024-10-14"]
---

# pandas numpyのna, nanの使い方

## 概要
 - pandasでは欠損値を`pd.NA`で表現する
   - `pd.NA`は 様々なデータ型に対応している
 - numpyでは欠損値を`np.nan`で表現する
   - `np.nan`は float型
 - 欠損値かどうかの判定
   - pandas
     - `pd.isna()`, `pd.notna()`
   - numpy
     - `np.isnan()`

## 例

```python
import pandas as pd
import numpy as np

# pd.isnaは様々なデータ型に対応している
assert pd.isna(pd.NA) == True
assert pd.isna(np.nan) == True
assert pd.isna(None) == True
assert pd.isna(1) == False
assert pd.isna("A") == False

# np.isnanは特定のデータ型に対応している
assert np.isnan(np.nan) == True
assert np.isnan(1.23) == False
```
