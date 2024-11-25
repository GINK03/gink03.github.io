---
layout: post
title: "pandas heatmap" 
date: 2024-11-25
excerpt: "pandas heatmap"
kaggle: true
tag: ["pandas"]
comments: false
sort_key: "2024-11-25"
update_dates: ["2024-11-25"]
---

# pandas heatmap

## 概要
 - `df.style.apply` を使用することでカラムの値に応じて色を変えることができる
   - 工夫を行うとヒートマップのような表を作成することができる

## サンプルコード

```python
import pandas as pd
import numpy as np

# サンプルデータを作成
data = {
    "Name": [chr(x) for x in range(ord("A"), ord("A")+10)],
    "column A": np.random.rand(10),
    "column B": np.random.rand(10),
    "column C": np.random.rand(10),
}
df = pd.DataFrame(data)
df["mean"] = df[["column A", "column B", "column C"]].mean(axis=1)
df.sort_values(by=["mean"], inplace=True)

# スタイルを適用する関数
def color_column(col):
    return [
        f"background-color: rgba(255, 0, 0, {value}); color: black;"
        for value in (col - col.min()) / (col.max() - col.min())
    ]

# 色を付けたい列名を指定
columns_to_style = ["column A", "column B", "column C", "mean"]

# スタイルを適用
styled_df = df.style.apply(color_column, axis=0, subset=columns_to_style)

# 表示
styled_df
```

<div align="center">
  <img src="https://gimpeik.s3.us-west-004.backblazeb2.com/Images-2024/Screenshot+2024-11-25+at+17.22.14.png" alt="pandas heatmap" width="100%">
</div>
