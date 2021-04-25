---
layout: post
title: "warshall-floyd"
date: 2021-04-25
excerpt: "ワーシャル-フロイド法について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "network", "graph", "warshall-floyd", "floyd-warshall", "ワーシャル-フロイド法"]
comments: false
---

# ワーシャル-フロイド法について
 - 英名は`floyd-warshall`
 - 重み付き有方向グラフのすべてのノードの最短経路を解くアルゴリズム
   - すべての辺からのアクセスを仮定しその最小値を取得する
 - 計算量`O(V^3)`であり、すべてのノードの最短距離を計算するときはダイクストラ方より早い


## 例; 全点対最短経路問題

[典型アルゴリズム問題集; E - 全点対最短経路問題](https://atcoder.jp/contests/typical-algorithm/tasks/typical_algorithm_e)


```python
import math

N, M = map(int, input().split())

mat = [[math.inf] * N for _ in range(N)]

for _ in range(0, M):
    u, v, c = map(int, input().split())
    mat[u][v] = c

# 同じノード上の距離は0とする
for i in range(0, N):
    mat[i][i] = 0

# ワーシャルフロイド法
for k in range(0, N):
    for x in range(0, N):
        for y in range(0, N):
            mat[x][y] = min(mat[x][y], mat[x][k] + mat[k][y])


# すべての頂点の組について最短距離を計算する
ans = 0
for i in range(0, N):
    for j in range(0, N):
        ans += mat[i][j]

print(ans)
```
