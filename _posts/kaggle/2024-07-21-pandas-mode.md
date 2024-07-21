---
layout: post
title: "pandas mode"
date: 2024-7-21
excerpt: "pandas mode"
project: false
kaggle: true
hide_from_post: true
tag: ["python", "pandas", "チートシート"]
comments: false
sort_key: "2024-07-21"
update_dates: ["2024-07-21"]
---

# pandas mode

## 概要
 - pandasのSeriesやDataFrameに対して、最頻値を取得する関数　
 - 最頻値は複数ある可能性があるため、Seriesで返される

## 具体例

```python
import pandas as pd

# サンプルデータ
data = pd.Series([1, 2, 2, 2, 3, 4, 4, 4, 5, 5])

# 最頻値の計算
mode_result: pd.Series = data.mode()

print(f"Mode: {mode_result.tolist()}")
"""
Mode: [2, 4]
"""
```

## 参考
 - [pandas.DataFrame.mode](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.mode.html)
