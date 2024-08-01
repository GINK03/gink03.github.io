---
layout: post
title: "pandas qcut" 
date: 2024-08-01
excerpt: "pandasのqcutの使い方"
kaggle: true
tag: ["python", "pandas", "qcut", "チートシート"]
comments: false
sort_key: "2024-08-01"
update_dates: ["2024-08-01"]
---

# pandasのqcutの使い方

## 概要
 - 連続値を整数値(カテゴリ変数)に変換する処理
 - binsで区分を設定できる
 - `pd.cut` との違いは、`pd.qcut` は分位数で区分する

## サンプルコード

**qcutとcutの違い**
```python
df = pd.DataFrame()
df["val"] = np.random.normal(1, 1, 10000)
df["cat_by_cut"] = pd.cut(df["val"], 3, labels=["low", "mid", "high"]) 
df["cat_by_qcut"] = pd.qcut(df["val"], 3, labels=["low", "mid", "high"]) 

# 値の範囲が異なる
display(df["cat_by_cut"].value_counts().to_frame())
"""
| cat_by_cut   |   count |
|:-------------|--------:|
| mid          |    8366 |
| low          |    1119 |
| high         |     515 |
"""

# ほぼ同じ数になる
display(df["cat_by_qcut"].value_counts().to_frame())
"""
| cat_by_qcut   |   count |
|:--------------|--------:|
| mid           |    3334 |
| low           |    3333 |
| high          |    3333 |
"""
```

**edgeの確認**
```python
_, bin_edges = pd.cut(df["val"], 3, retbins=True)
print(bin_edges) # [-3.06438592 -0.21070577  2.63443895  5.47958367]

_, qbin_edges = pd.qcut(df["val"], 3, retbins=True)
print(qbin_edges) # [-3.05585049  0.57646289  1.42827745  5.47958367]
```

## 参考
 - [pandas.qcut - pandas.pydata.org](https://pandas.pydata.org/docs/reference/api/pandas.qcut.html)
