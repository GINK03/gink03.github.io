---
layout: post
title: "python annoy"
date: 2023-05-09
excerpt: "pythonのannoyの使い方"
config: true
tag: ["python", "annoy"]
comments: false
sort_key: "2023-05-09"
update_dates: ["2023-05-09"]
---

# pythonのannoyの使い方

## 概要
 - RPF（Random Projection Forest）を利用して高次元データの近似最近傍検索を効率的に行う
   - RPFは[/faiss/](/faiss/)にはない機能
 - annoyはbuildしたインデックスに後から要素を追加することができない

## インストール

**ダウンロード**
```console
$ pythno3 -m pip install annoy
```

## 具体例

**インデックスの構築**
```python
from annoy import AnnoyIndex
import random

# ベクトルの次元を指定
dimension = 40

# Annoyインデックスの初期化
index = AnnoyIndex(dimension, 'angular')

# サンプルデータの追加
n_items = 1000
for i in range(n_items):
    v = [random.gauss(0, 1) for z in range(dimension)]
    index.add_item(i, v)

# インデックスの構築
n_trees = 10
index.build(n_trees)
```

**検索**
```python
# クエリベクトルの作成
query_vector = [random.gauss(0, 1) for z in range(dimension)]

# 最も近いアイテムの検索
n_nearest_neighbors = 10
nearest_neighbors = index.get_nns_by_vector(query_vector, n_nearest_neighbors)
print(nearest_neighbors) # indexで得られる
```

## Google Colab
 - [annoy-example](https://colab.research.google.com/drive/1M6GVFzEU6Fq608BGyV5nA7ouvtsJUV5f?usp=sharing)


