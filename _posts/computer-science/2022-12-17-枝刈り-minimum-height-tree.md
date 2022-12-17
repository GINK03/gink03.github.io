---
layout: post
title: "枝刈り(minimum height tree)"
date: 2022-12-17
excerpt: "枝刈り(minimum height tree)について"
computer_science: true
tag: ["アルゴリズム", "枝刈り", "minimum height tree", "MHT", "トポロジカルソート"]
comments: false
sort_key: "2022-12-17"
update_dates: ["2022-12-17"]
---

# 枝刈り(minimum height tree)について

## 概要
 - 無方向(有方向でも?)のグラフで中心となるノードを見つけるテクニック
 - トポロジカルソートと呼ばれることもある
 - 具体的手法
   - `繋がりが1しかないノードを削除` -> `他のノードから削除したノードを削除` -> `ノードが2つ以下になるまで繰り返す`
 - 意味
   - `グラフで中心となるノード`は`ルートノードにした時、最も深さが浅いノード`となる
     - `minimum height tree(MHT)`を求める際に使用可能
 
## テンプレート

```python
from typing import *
import collections

def pruning(n:int, edges: List[List[int]]) -> List[int]:
    G = collections.defaultdict(set)
    for i, j in edges:
        G[i].add(j)
        G[j].add(i)

    def scan_is_leaf(G):
        is_leaf = []
        for k, leaves in G.items():
            if len(leaves) == 1:
                is_leaf.append(k)
        return is_leaf

    is_leaf = scan_is_leaf(G)

    while len(G) > 2:
        next_is_leaf = []
        for leaf in is_leaf:
            for k in G[leaf]:
                if leaf in G[k]:
                    G[k].remove(leaf)
                    if len(G[k]) == 1:
                        next_is_leaf.append(k)
            del G[leaf]
        # is_leaf = scan_is_leaf(G)
        # anses.append(is_leaf)
        is_leaf = next_is_leaf
    return list(G.keys())

pruning(n = 4, edges = [[1,0],[1,2],[1,3]]) # [1]
pruning(n = 6, edges = [[3,0],[3,1],[3,2],[3,4],[5,4]]) # [3,4]
```

---

## 参考
 - [310. Minimum Height Trees/LeetCode](https://leetcode.com/problems/minimum-height-trees/description/)
