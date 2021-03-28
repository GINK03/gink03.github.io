---
layout: post
title: "union find(disjoint set)"
date: 2020-10-01
excerpt: "union find(disjoint set)"
project: false
config: true
comuter_science: true
tag: ["computer science", "data structure", "union find", "disjoint set"]
comments: false
---

# union find(disjoint set)

## 概要
 - 与えられた列に対して、リンク関係から２つ以上に分けられるとき、効率的に分割するアルゴリズム
 - **具体的な挙動**
   - `-1` や特定の数で初期化して根構造を再起でたどってpushしていくというもの
   - クラス分けや、所属分けなどで効率的
   - カスタマイズ要素多いのでどこをどういじるか
	 - 高さを求める等のオプションが付くことがある

## シンプルな実装例

**クラス定義**
```python
class DisjointSet:
    def __init__(self, vertices, parent):
        self.vertices = vertices
        self.parent = parent

    def find(self, item):
        if self.parent[item] == item:
            return item
        else:
            return self.find(self.parent[item])

    def union(self, set1, set2):
        self.parent[set1] = set2
```

**動作確認**
```python
def main():
    vertices = ['a', 'b', 'c', 'd', 'e', 'h', 'i']
    parent = {}

    for v in vertices:
        parent[v] = v

    ds = DisjointSet(vertices, parent)
    print("Print all vertices in genesis: ")
    ds.union('b', 'd')

    ds.union('h', 'b')
    print(ds.find('h')) # prints d (OK)
    ds.union('h', 'i')
    print(ds.find('i')) # prints i (expecting d)

main()
```

**colabによる挙動の確認**
 - [colab](https://colab.research.google.com/drive/1FkGrNChetNH2w3ZjrItNTDSOZuwp9SbR?usp=sharing)


## 競プロによる例
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
