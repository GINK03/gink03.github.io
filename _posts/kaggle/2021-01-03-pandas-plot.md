---
layout: post
title: "pandas plot"
date: 2021-01-03
excerpt: "pandas plotのチートシート"
project: false
kaggle: true
hide_from_post: true
tag: ["python", "pandas", "チートシート"]
comments: false
---

# pandas plotのチートシート

## 概要
 - pandasは一部matplotをラップしており、pandasの関数から描画が可能である

## ヒストグラムの描画
 - series, dataframeインスタンスに`hist`メソッドが存在し、描画が可能
 - `bins`はbinの数と分け方のリストのどちらも取れる

```python
ax = df["size"].hist(legend=False, bins=10) # 描画インスタンスが得られる
ax.set_xlabel("xlabel")
ax.set_ylabel("ylabel")
display(ax)
```

## 参考
 - [pandas.DataFrame.hist](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.hist.html)
