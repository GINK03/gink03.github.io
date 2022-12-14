---
layout: post
title: "2Dのunion-find"
date: 2022-12-14
excerpt: "2Dのunion-findについて"
computer_science: true
tag: ["アルゴリズム", "union-find", "2D"]
comments: false
sort_key: "2022-12-14"
update_dates: ["2022-12-14"]
---

# 2Dのunion-findについて

## 概要
 - 2Dで考える際に、union-findのparentsのlist構造はflattenしてアクセスする必要があり、この点を気をつければ通常のunion-findとして扱える
 
## 具体例
 - 概要
   - 2Dのmatrix上に島が何個あるかをカウントする

```python
from typing import *
import collections
class UnionFind:
    def __init__(self, n):
        self.n = n
        self.parents = [-1] * n
    def find(self, x):
        if self.parents[x] < 0:
            return x
        else:
            self.parents[x] = self.find(self.parents[x])
            return self.parents[x]
    def union(self, x, y):
        x = self.find(x)
        y = self.find(y)
        if x == y:
            return
        if self.parents[x] > self.parents[y]:
            x, y = y, x
        self.parents[x] += self.parents[y]
        self.parents[y] = x

def wrap(m: int, n: int, positions: List[List[int]]):
    rs = []
    uf = UnionFind(m*n)
    mat = [[0] * n for _ in range(m)]
    for mi, ni in positions:
        mat[mi][ni] = 1
        now_i = mi * n + ni
        if uf.parents[now_i] == -1:
            uf.parents[now_i] -= 1
        for md, nd in [(-1, 0), (0, -1), (0, 1), (1, 0)]:
            if mi + md < 0 or ni + nd < 0 or mi + md >= m or ni + nd >= n:
                continue
            if mat[mi+md][ni+nd] == 1:
                now_i = mi * n + ni
                next_i =  (mi+md) * n + (ni+nd)
                uf.union(now_i, next_i)
        r = len([x for x in uf.parents if x <= -2])
        rs.append(r)
    return rs

wrap(m = 3, n = 3, positions = [[0,0],[0,1],[1,2],[2,1]])
wrap(m = 1, n = 1, positions = [[0,0]])
```


---

## 参考
 - [305. Number of Islands II/LeetCode](https://leetcode.com/problems/number-of-islands-ii)

