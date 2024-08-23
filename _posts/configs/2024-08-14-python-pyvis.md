---
layout: post
title: "python pyvis"
date: 2024-08-14
excerpt: "python pyvisの使い方"
tags: ["python", "pyvis"]
config: true
comments: false
sort_key: "2024-08-14"
update_dates: ["2024-08-14"]
---

# python pyvisの使い方

## 概要
 - グラフを描画するためのライブラリ
 - jupyter notebook上で描画するには、`notebook=True` を指定し、`IPython.display.IFrame` で表示する
 - `add_node` でノードを追加し、`add_edge` でノードを引数にエッジを追加する
 - `Network(directional=True)` で有向グラフを作成する

## インストール

```console
$ pip install pyvis
```

## 使い方(共起ネットワークの可視化)

```python
from sklearn.datasets import fetch_20newsgroups
from pyvis.network import Network
from collections import defaultdict
import pandas as pd
import numpy as np

# 20 Newsgroups データセットの取得
newsgroups = fetch_20newsgroups(subset='train', categories=['sci.space'], remove=('headers', 'footers', 'quotes'))

# スライディングウィンドウのサイズ
window_size = 5

# 共起を格納する辞書
cooccurrences = defaultdict(int)
word_frequency = defaultdict(int)

# スライディングウィンドウを使って共起を計算
for text in newsgroups.data[:100]:  # 最初の100文書だけを対象に
    words = text.lower().split()
    for i in range(len(words) - window_size + 1):
        window = words[i:i + window_size]
        for j in range(len(window)):
            # 各単語の出現回数をカウント
            word_frequency[window[j]] += 1
            for k in range(j + 1, len(window)):
                pair = tuple(sorted([window[j], window[k]]))
                cooccurrences[pair] += 1

# 共起データをデータフレームに変換
df = pd.DataFrame(cooccurrences.items(), columns=["tuple", "freq"])

# 頻度でソートし、正規化した重みを計算
df.sort_values(by="freq", ascending=False, inplace=True)
df["weight"] = df["freq"] / df["freq"].max()

# 上位500件のエッジを取得し、重みが0.05以上のものをフィルタリング
df = df.head(500)
df.query('weight >= 0.05', inplace=True)

# ネットワークの初期化
net = Network(height='750px', width='100%', cdn_resources='in_line', notebook=True)

# ノードとエッジの追加
for _, row in df.iterrows():
    node1, node2 = row["tuple"]
    
    # ノードのサイズを単語の出現回数に基づいて設定
    size1 = np.log1p(word_frequency[node1]) * 3
    size2 = np.log1p(word_frequency[node2]) * 3
    
    net.add_node(node1, label=node1, size=size1)
    net.add_node(node2, label=node2, size=size2)
    net.add_edge(node1, node2, value=row["weight"])

# ネットワークの描画
net.show("word_cooccurrence_network_news_filtered.html")

# 描画したネットワークを表示
from IPython.display import IFrame

IFrame(src="word_cooccurrence_network_news_filtered.html", width="100%", height="750px")
```
