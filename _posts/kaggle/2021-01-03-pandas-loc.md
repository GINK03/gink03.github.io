---
layout: post
title: "pandas loc"
date: 2021-01-03
excerpt: "pandas locのチートシート"
project: false
kaggle: true
hide_from_post: true
tag: ["python", "pandas", "チートシート"]
comments: false
sort_key: "2022-05-24"
update_dates: ["2022-05-24", "2022-04-14"]
---

# pandas locのチートシート

## 概要
 - dataframeにはindexとカラム名を指定して操作する方法がある

## 具体例

```python
import pandas as pd
import numpy as np

df = pd.DataFrame({"v": np.random.random(1000)})
# vが0.5より大きいindexを取り出す
index = df.query("v > 0.5").index

# vが0.5より大きい箇所に"p"というカラムを新設
# 0.1が代入されていない0.5以下のrowには"NaN"が入る
df.loc[index, "p"] = 0.1

# pに0.1を加える
# pがNaNのとき、足し算は行われない
df["p"] += 0.1

# vが0.5より大きいrowにたいしてpを引数にapply
df.loc[index, "p"].apply(lambda x: "nanです" if np.isnan(x) else x + 0.1))

# 代入も可能である
df.loc[index, "p"] = df.loc[index, "p"].apply(lambda x: "nanです" if np.isnan(x) else x + 0.1)
```

## Google Colab
 - [pandas-loc](https://colab.research.google.com/drive/1pvu6a0kwYhupJc9OFPk1PSUcXrdS-mNz?usp=sharing)
