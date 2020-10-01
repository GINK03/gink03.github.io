---
layout: post
title:  "union_find"
date:   2020-10-01
excerpt: "union_find"
project: false
config: true
tag: []
comments: false
---

# union_find

## 概要
 - `-1` や特定の数で初期化して根構造を再起でたどってpushしていくというもの
 - クラス分けや、所属分けなどで効率的
 - カスタマイズ要素多いのでどこをどういじるか


## 例
 - https://atcoder.jp/contests/abc177/tasks/abc177_d

```python
import sys
sys.setrecursionlimit(1500)

class UnionFind:
    def __init__(self, N):
        # 最初はすべて根で初期化
        self.par = [-1 for i in range(N)]

    def root(self, x):
        # print(x, self.par)
        if self.par[x] == x:
            return x
        elif self.par[x] < 0:
            # par = self.root(self.par[x])
            # self.par[x] = x
            return x
        else:
            par = self.root(self.par[x])
            self.par[x] = par
            return par
        
    def unite(self, x, y):
        x = self.root(x)
        y = self.root(y)
        if x == y:
            return
        if self.par[x] > self.par[y]:
            x, y = y, x
        self.par[x] += self.par[y]
        self.par[y] = x
        return True

    def same(self, x, y):
        rx = self.root(x)
        ry = self.root(y)
        return rx == ry

    def size(self, x):
        return -self.par[self.root(x)]

N,M=map(int,input().split())

# union find構造を作る
uf = UnionFind(N)
for _ in range(M):
    A,B=map(lambda x:int(x)-1, input().split())
    uf.unite(A,B)

print(-min(uf.par))
```
