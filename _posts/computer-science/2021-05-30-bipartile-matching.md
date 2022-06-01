---
layout: post
title: "bipartile matching"
date: 2021-05-30
excerpt: "二部マッチング問題(bipartile matching)について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "math", "integer", "bipartile matching"]
comments: false
sort_key: "2021-05-30"
update_dates: ["2021-05-30"]
---

# bipartile matching問題について
 - 実装は最大流問題をカスタマイズすることで実現できる
 - `dinic法`などをベースに流入元のエッジと流出先のエッジを用意すれば良い

## dinic法をベースにエッジの調整で実現する

**問題**  
[Bipartite Matching](https://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_7_A)  

**解答**  

```python
import collections
# from dataclasses import dataclass
# from typing import Optional
# @dataclass
class Entry:
    def __init__(self, to, cost, backward):
        self.to = to
        self.cost = cost
        self.backward = backward

class Dinic:
    def __init__(self, N: int):
        '''
        Args:
            N (int): グラフのエッジ数(V)
        '''
        self.N = N
        self.G = [[] for i in range(N)]

    def add(self, fr, to, cost):
        forward = Entry(to=to, cost=cost, backward=None)
        forward.backward = backward = Entry(to=fr, cost=0, backward=forward)
        self.G[fr].append(forward)
        self.G[to].append(backward)

    def add_multi(self, v1, v2, cost1, cost2):
        edge1 = [v2, cost1, None]
        edge1[2] = edge2 = [v1, cost2, edge1]
        self.G[v1].append(edge1)
        self.G[v2].append(edge2)

    def bfs(self, s: int, t: int) -> int:
        # level変数は階層の深さ
        self.level = level = [None]*self.N
        que = collections.deque([s])
        level[s] = 0
        G = self.G
        while que:
            v = que.popleft()
            lv = level[v] + 1
            for ne in G[v]:
                if ne.cost and level[ne.to] is None:
                    level[ne.to] = lv
                    que.append(ne.to)
        return level[t] is not None

    def dfs(self, s: int, t: int, f, trace: list) -> int:
        trace.append(s)
        if s == t:
            # print(trace)
            return f, trace
        level = self.level
        for ne in self.it[s]:
            if ne.cost and level[s] < level[ne.to]:
                d, _ = self.dfs(ne.to, t, min(f, ne.cost), trace[:])
                if d > 0:
                    ne.cost -= d
                    ne.backward.cost += d
                    return d, trace
        return 0, trace

    def flow(self, s: int, t: int) -> int:
        flow = 0
        INF = float('inf') # 10**9 + 7
        G = self.G
        while self.bfs(s, t):
            *self.it, = map(iter, self.G)
            f = INF
            while f:
                f, _ = self.dfs(s, t, INF, [])
                flow += f
        return flow
	
X, Y, E =map(int,input().split())

matchs = []
for e in range(E):
    x, y = map(int,input().split())
    matchs.append( (x, y+X) )


men = list(set([m[0] for m in matchs]))
women = list(set([m[1] for m in matchs]))


s = X + Y + 1
e = X + Y + 2

dinic = Dinic(X+Y+3)

# menとマップ
for man in men:
    dinic.add(fr=s, to=man, cost=1)

# menとwomenをマップ
for man, woman in matchs:
    dinic.add(fr=man, to=woman, cost=1)

# womenをeにマップ
for woman in women:
    dinic.add(fr=woman, to=e, cost=1)

print(dinic.flow(s,e))
```

