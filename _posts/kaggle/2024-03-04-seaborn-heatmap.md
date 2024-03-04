---
layout: post
title: "seaborn heatmap"
date: 2024-03-04
excerpt: "seaborn heatmap"
tags: ["seaborn", "python", "matplotlib", "可視化"]
kaggle: true
comments: false
sort_key: "2024-03-04"
update_dates: ["2024-03-04"]
---

# seaborn heatmap

## 概要
 - seabornでヒートマップを描画する
 - 相関行列を可視化するのに便利

## サンプルコード(株価の相関行列を可視化)

```python
import seaborn as sns
import matplotlib.pyplot as plt

pivot = df.pivot(index=["date"], columns=["ticker"], values=["Close"]).reset_index(drop=True)
pivot.columns = pivot.columns.droplevel()
sns.heatmap(pivot.corr(), vmin=0.8, vmax=1, cmap="Greens")
```

 - `pivot`は日付をindex、銘柄をcolumnsに持つDataFrame
 - `pivot.corr()`で相関行列を計算
 - `sns.heatmap`でヒートマップを描画
   - `vmin`と`vmax`でカラーバーの最小値と最大値を指定
   - `cmap`でカラーマップを指定

<div align="center">
  <img src="https://f004.backblazeb2.com/file/gimpeik/Images-2024/heatmap.png" alt="heatmap" width="600"/>
</div>
