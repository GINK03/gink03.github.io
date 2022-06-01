---
layout: post
title: "union find(disjoint set)"
date: 2020-10-01
excerpt: "union find(disjoint set)"
project: false
comuter_science: true
tag: ["computer science", "data structure", "union find", "disjoint set"]
comments: false
sort_key: "2021-08-15"
update_dates: ["2021-08-15","2021-08-14","2021-06-16","2021-06-06","2021-06-03","2021-05-29","2021-04-29","2021-03-28","2021-03-28"]
---

# union find(disjoint set)

## 概要
 - 与えられた列に対して、リンク関係から２つ以上に分けられるとき、効率的に分割するアルゴリズム
 - **具体的な挙動**
   - `-1` や特定の数で初期化して根構造を再帰でたどってrootを計算していくというもの
   - クラス分けや、所属分けなどで効率的
   - カスタマイズ要素多いのでどこをどういじるか
     - 高さを求める等のオプションが付くことがある
   - 閉路の検出でも使うことができ、閉路が存在するとき、union時にparentの衝突が発生するのでそれを利用する

## シンプルな実装例
以下の例では、最大のノードへのリンクを求めるというものになる  


## 競プロによる例
 - ルートノードの参照料を知りたい場合もサポートできるように拡張したもの
 - `-1`で初期化することがより多い
 - ***参考***
   - [AtCoder Beginner Contest 120; D - Decayed Bridges](https://atcoder.jp/contests/abc120/tasks/abc120_d)
   - https://atcoder.jp/contests/abc177/tasks/abc177_d

```python
import collections
class UnionFind:
    def __init__(self, n):
        self.n = n
        self.parents = [-1] * n
        self.has_cycles = [0] * n
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
        # ここに閉路情報を入れることができる
        if x == y:
            self.has_cycles[x] = 1
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
    def same(self, x, y):
        # 同じルートを持つか
        return self.find(x) == self.find(y)
    def roots(self):
        # どのノードがrootとなるか
        return [i for i, x in enumerate(self.parents) if x < 0]
    def group_count(self):
        # グループの個数
        return len(self.roots())
    def all_group_members(self) -> "Tuple[GroupMember, GroupCycle]":
        # rootをkeyに子をvalueのlistに, 閉路情報も返す
        group_members = collections.defaultdict(list)
        for member in range(self.n):
            group_members[self.find(member)].append(member)
        group_cycle = collections.defaultdict(bool)
        for group, members in group_members.items():
            group_cycle[group] = True if any([self.has_cycles[member] for member in members]) else False
        return group_members, group_cycle
```

---

### 例; グループ間の行き来の量がわかると平衡状態かどうかを判定できる例

**問題**  
 - [AtCoder Regular Contest 106; B - Values](https://atcoder.jp/contests/arc106/tasks/arc106_b)  

**説明**  
 - 変化可能かは閉区間を求めることで判明する  
 - 閉区間はunion findで知ることができる  

**解答**  
 - [提出](https://atcoder.jp/contests/arc106/submissions/22967713)

---

### 例; 閉路の検出
**問題**  
 - [AtCoder Regular Contest 037; B - バウムテスト](https://atcoder.jp/contests/arc037/tasks/arc037_b)  

**解説**  
dfsでも閉路チェックができるがコードをまとめたいときにはunion findが便利  

**解答**  
 - [提出](https://atcoder.jp/contests/arc037/submissions/23142427)

---

### 例; ドット状のグラフの結合判定  
ドット上のものもunion findが適応可能なグラフであると気づけると早い  

**問題**  
 - [競プロ典型 90 問; 012 - Red Painting](https://atcoder.jp/contests/typical90/tasks/typical90_l)

**解答**  
 - [提出](https://atcoder.jp/contests/typical90/submissions/23199867)

---

### 例; swap法則とUnionFind

**問題**  
 - [AtCoder Regular Contest 097; D - Equals](https://atcoder.jp/contests/arc097/tasks/arc097_b)

**解説**  
 - swap可能になる ≡ ネットワーク的に結合する ≡ UnionFindで結合状態を知ることができる

**解答**  
 - [提出](https://atcoder.jp/contests/arc097/submissions/23513430)

--- 

### 例; UnionFildを複雑な手続きで利用して解答を得る例
**問題**  
 - [AtCoder Beginner Contest 157; D - Friend Suggestions](https://atcoder.jp/contests/abc157/tasks/abc157_d)

**解説**  
 - 友達のグラフでufを初期化する
 - ブロック関係にあるときは、`友達関係になりうる同じグループである` かつ `ブロック関係である` とき、候補から除外する
 - ブロック処理のプロセスにてもufを用いるので複雑

**解答**  
 - [提出](https://atcoder.jp/contests/abc157/submissions/25014934)

---

### 例; すべての最短経路の最大のコストの和
 - 何度も見返したがunionfindが適応例だとはなかなか発想が至らない

**問題**  
 - [AtCoder Beginner Contest 214; D - Sum of Maximum Weights](https://atcoder.jp/contests/abc214/tasks/abc214_d)

**解説**  
 - 最短パスに含まれるパスの最大のコストのすべての和
 - コストが小さい順でソートして、`コスト * group_size(l) * group_size(r)`を累積していくと答えになる 

**解答**  
 - [提出](https://atcoder.jp/contests/abc214/submissions/25058676)

--- 

### 例; 重み付きunion find

**問題**  
 - [AtCoder Beginner Contest 087; D - People on a Line](https://atcoder.jp/contests/abc087/tasks/arc090_b)

**解説**  
 - 重み付きunion findは実装がそれ専用になる
 
**解答**  
 
```python
class WeightedUnionFind():
    def __init__(self, n):
        self.n = n
        # 各親要素の番号を格納 rootの場合は、そのグループの要素数
        self.parents = [-1] * n
        self.diff_weight = [0] * n
    def find(self, x):
        if self.parents[x] < 0:
            return x
        else:
            # 根を見つけると同時に、他の要素の親を根に変更(経路圧縮)
            r = self.find(self.parents[x])
            # 親を遡りながら、重みの累積和を取る
            self.diff_weight[x] += self.diff_weight[self.parents[x]]
            self.parents[x] = r
            return self.parents[x]
    def weight(self, x):
        # 経路圧縮
        self.find(x)
        return self.diff_weight[x]
    def diff(self, x, y):
        return self.weight(y) - self.weight(x)
    def union(self, x, y, w):
        # xとyそれぞれについて、rootとの重み差分を補正
        w += self.weight(x)
        w -= self.weight(y)
        x = self.find(x)
        y = self.find(y)
        if x == y:
            return
        if self.parents[x] > self.parents[y]:
            x, y = y, x
            w = -w
        self.parents[x] += self.parents[y]
        self.parents[y] = x
        # x が y の親になるので、x と y の差分を diff_weight[y] に記録
        self.diff_weight[y] = w
    def size(self, x):
        return -self.parents[self.find(x)]
    def same(self, x, y):
        return self.find(x) == self.find(y)
    def members(self, x):
        root = self.find(x)
        return [i for i in range(self.n) if self.find(i) == root]
    def roots(self):
        return [i for i, x in enumerate(self.parents) if x < 0]
    def group_count(self):
        return len(self.roots())
    def all_group_members(self):
        group_members = defaultdict(list)
        for member in range(self.n):
            group_members[self.find(member)].append(member)
        return group_members
    def __str__(self):
        return '\n'.join(f'{r}: {m}' for r, m in self.all_group_members().items())


N,M=map(int,input().split())
wuf = WeightedUnionFind(n=N)
for _ in range(M):
    l, r, d = map(int,input().split())
    l-=1; r-=1;
    if wuf.same(l, r):
        if wuf.diff(l,r) != d:
            print("No")
            exit()
    else:
        wuf.union(l, r, d)
print("Yes")
```
