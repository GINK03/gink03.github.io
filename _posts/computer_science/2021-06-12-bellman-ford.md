---
layout: post
title: "bellman-ford algorithm"
date: 2021-06-12
excerpt: "ベルマンフォード法について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "minimum", "graph"]
comments: false
---

# ベルマンフォード法について
 - 最短経路を探索するアルゴリズム
 - dijkstraより計算コストは重いが、ワーシャルフロイドよりは軽い
 - 負の値を辺が持っていても矛盾を起こさないためそこはいいかもしれない
   - その代わり、接続されていない独立した木などを区別できないので矛盾を起こす
 - 負閉路を検出することができる

## 具体的なコード

```python
V,E,R=map(int,input().split())

G = []
for _ in range(E):
    x, y, c = map(int,input().split())
    G.append( (x, y, c) )

"""bellman fordで最小コスト計算"""
def bellman_ford(s: "start", N: "edge_num") -> "Optinal[List[int]]":
    d = [float("inf")]*N # 各頂点への最小コスト
    d[s] = 0 # 自身への距離は0
    for cnt  in range(N):
        update = False # 更新が行われたか
        for i, j, c in G:
            if d[j] > d[i] + c:
                d[j] = d[i] + c
                update = True
        if not update:
            break
        # 負閉路が存在
        if cnt == N - 1:
            return None
    return d

ret = bellman_ford(R, N=V)
if ret is None:
    print("NEGATIVE CYCLE")
else:
    ret = ["INF" if r == float("inf") else r for r in ret]
    print(*ret, sep="\n")
```
 - [Single Source Shortest Path (Negative Edges)](https://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_B&lang=ja)

## 例; 閉路を検出しつつラベル付けする

**問題**  
 - [AtCoder Beginner Contest 137; E - Coins Respawn](https://atcoder.jp/contests/abc137/tasks/abc137_e)

**解答**  

```python
N,M,P=map(int,input().split())
G = []
for _ in range(M):
    x, y, c = map(int,input().split())
    G.append( (x-1, y-1, P-c) )

"""bellman fordで最小コスト計算"""
def bellman_ford(s: "start", N: "edge_num") -> "List[int]":
    d = [float("inf")]*N # 各頂点への最小コスト
    d[s] = 0 # 自身への距離は0
    for cnt in range(2*N):
        for fr, to, c in G:
            if d[to] > d[fr] + c:
                d[to] = d[fr] + c
                # 負閉路が存在
                if cnt == N - 1:
                    d[to] = -float("inf")
    return d

ret = bellman_ford(0, N=N)
# print(ret)

if ret[-1] != -float('inf'):
    print(max(0, -ret[-1]))
else:
    print(-1)
```
