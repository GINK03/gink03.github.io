---
layout: post
title: "pandas replace"
date: 2021-01-03
excerpt: "pandas replaceのチートシート"
tag: ["python", "pandas", "pd.Series", "チートシート"]
kaggle: true
sort_key: "2022-05-30"
update_dates: ["2022-05-30"]
comments: false
---

# pandas replaceのチートシート

## 概要
 - `pd.Series`の値を置き換える
 - 何通りが方法があり、dict型で置き換える方法と、listで置き換える方法がある
 - `pd.NaT`や`None`もハンドルすることができ、時間のパースが絡む際に便利
   - `pd.NaT`; Not a Time

## 具体例

```python
import pandas as pd

df = pd.DataFrame({"dt": ["2099-01-01", "2099-01-02", None]})
df["dt"] = pd.to_datetime(df["dt"])

print(df)
"""
          dt
0 2099-01-01
1 2099-01-02
2        NaT
"""

df["dt"].replace({pd.NaT: None}, inplace=True)

print(df)
"""
                    dt
0  2099-01-01 00:00:00
1  2099-01-02 00:00:00
2                 None
"""

# 20000, 23000の値を50000に置き換える
series.replace(to_replace=[20000,23000], value=50000)
```

## 参考
 - [pandas.Series.replace¶](https://pandas.pydata.org/docs/reference/api/pandas.Series.replace.html)
 - [Pandas replace all NaN and NaT values with None](https://iarp.github.io/python/pandas-replace-nan-nat-with-none.html)
