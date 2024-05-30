---
layout: post
title: "seaborn displot"
date: 2024-04-30
excerpt: "seaborn displot"
tags: ["seaborn", "python", "matplotlib", "可視化"]
kaggle: true
comments: false
sort_key: "2024-04-30"
update_dates: ["2024-04-30"]
---

# seaborn displot 

## 概要
 - seabornでヒストグラムを描画する
   - 2024年現在、`sns.distplot`は非推奨

## サンプルコード
 - tipsデータセットを使ってヒストグラムを描画する
   - `total_bill`: 会計金額
   - `time`: 時間帯(Lunch, Dinner)

```python
import seaborn as sns
import matplotlib.pyplot as plt

# データセットの読み込み
data = sns.load_dataset("tips")

# displot を使ってヒストグラムを描画
sns.displot(data['total_bill'])
```

**複数のヒストグラムを描画する場合**
 - time列の値によってヒストグラムを分割して描画

```python
sns.displot(data, x="total_bill", col="time", kde=True)
```

**同じグラフに複数のヒストグラムを描画する場合**
 - hue列の値によってヒストグラムを分割して描画
 - `kind='kde'` でカーネル密度推定で描画
 - `common_norm=False` で個々のヒストグラムで正規化

```python
sns.displot(data, 
            x="total_bill", 
            hue="time", 
            common_norm=False,
            kind="kde")
```

**binsの切り方を指定する場合**
 - `bins` で切り方を指定

```python
bins = [0, 10, 15, 20, 25, 30, 35, 40, 45, 50, 60]
sns.displot(data['total_bill'], bins=bins)
```
