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
   - `-1` や特定の数で初期化して根構造を再帰でたどってrootを計算していくというもの
   - クラス分けや、所属分けなどで効率的
   - カスタマイズ要素多いのでどこをどういじるか
	 - 高さを求める等のオプションが付くことがある

## シンプルな実装例
以下の例では、最大のノードへのリンクを求めるというものになる  

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
    parent = vertices

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
 - ルートノードの参照料を知りたい場合もサポートできるように拡張したもの
 - `-1`で初期化することがより多い
 - ***参考***
   - [AtCoder Beginner Contest 120; D - Decayed Bridges](https://atcoder.jp/contests/abc120/tasks/abc120_d)
   - https://atcoder.jp/contests/abc177/tasks/abc177_d

```python
class UnionFind:
    def __init__(self, n):
        self.n = n
        self.parents = [-1] * n

    def find(self, x):
        if self.parents[x] < 0:
            return x
        else:
            # 積極的aggregation
            self.parents[x] = self.find(self.parents[x])
            return self.parents[x]

    def union(self, x, y):
        x = self.find(x)
        y = self.find(y)

        # 同じノード同士ならばなにもしない
        if x == y:
            return

        # 既知の親子で小さいものが左に来るべき
        if self.parents[x] > self.parents[y]:
            x, y = y, x

        # rootノードを負の値で参照量をカウントしたいため、このような+=が入っている
        self.parents[x] += self.parents[y]
        # rootノードでなければ、正のindex値を入れる
        self.parents[y] = x

    def size(self, x):
        # rootノードの参照料を保存したものを取り出している
        return -self.parents[self.find(x)]
```
