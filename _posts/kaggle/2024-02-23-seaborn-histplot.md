---
layout: post
title: "seaborn histplot"
date: 2024-02-23
excerpt: "seaborn histplot"
tags: ["seaborn", "python", "matplotlib", "可視化"]
kaggle: true
comments: false
sort_key: "2024-02-23"
update_dates: ["2024-02-23"]
---

# seaborn histplot

## 概要
 - distplotが非推奨になり、代わりにhistplot, displotが推奨になった
 - 通常のヒストグラムを描画する

## サンプルコード

```python
import seaborn as sns
import matplotlib.pyplot as plt

f, axs = plt.subplots(nrows=1, ncols=2, figsize=(30, 30))
ax0, ax1 = axs

# 0 ~ 1でノーマライズされたヒストグラム
# kde=Trueでカーネル密度推定も描画
sns.histplot(data=data, x="column", kde=True, bins=np.arange(0, 20, 0.25), stat="probability", ax=ax0)
ax0.set(xlim=(0, 20), xticks=np.arange(0, 20, 0.25), title="title")
ax0.set_xticklabels(ax0.get_xticklabels(), rotation=90)

# 平均値、中央値を描画
ax0.axvline(data["column"].mean(), color='r', linestyle='--', linewidth=2)
ax0.axvline(data["column"].median(), color='b', linestyle='--', linewidth=2)

# 累積ヒストグラム
sns.histplot(data=data, x="rate", kde=True, bins=np.arange(0, 20, 0.25), cumulative=True, stat="probability", ax=ax1)
# 0.05, 0.5の位置に線を引く
ax1.axhline(0.05, color='r', linestyle='-', linewidth=2)
ax1.axhline(0.50, color='r', linestyle=':', linewidth=2)
ax1.set(xlim=(0, 20), xticks=np.arange(0, 20, 0.25), title="title(cumulative)")
ax1.set_xticklabels(ax1.get_xticklabels(), rotation=90)
```
