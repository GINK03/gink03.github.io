---
layout: post
title: "primal dual法"
date: 2021-07-27
excerpt: "最最小費用流問題(primal dual法)について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "math", "primal dual"]
comments: false
---


# primal dual法
 - 最小費用流のアルゴリズム(容量+コストのネットワークを解ける)
 - dijkstraを改造したソリューション
	1. 最初に流せる量を決める
	2. dijkstra法により残渣グラフを考慮して、最もコストが安いノードを探す
	3. 流せるだけ流して残渣グラフを作る
	4. 流せる量を減算する
	5. 2 ~ 4を繰り返す
 - 計算量
   - O(F * E * log(V)) 

---

## 例; もっとも一般的な例　

**問題**  
 - [最小費用流](https://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_6_B&lang=ja)

**提出**  

```python
import heapq
class MinCostFlow:
    INF = float("INF")
    def __init__(self, N):
        self.N = N
        self.G = [[] for i in range(N)]
    def add_edge(self, fr, to, cap, cost):
        G = self.G
        G[fr].append([to, cap, cost, len(G[to])])
        G[to].append([fr, 0, -cost, len(G[fr])-1])
    def flow(self, s: "source", t: "sink", f: "流量") -> int:
        N = self.N; G = self.G
        INF = MinCostFlow.INF
        res = 0
        H = [0]*N # コストを計算するための累積値
        prv_v = [0]*N
        prv_e = [0]*N
        while f:
            dist = [INF]*N # コスト
            dist[s] = 0
            que = [(0, s)]
            while que:
                c, v = heapq.heappop(que)
                if dist[v] < c:
                    continue
                for i, (w, cap, cost, rev) in enumerate(G[v]):
                    if cap > 0 and dist[w] > dist[v] + cost + H[v] - H[w]:
                        dist[w] = r = dist[v] + cost + H[v] - H[w]
                        prv_v[w] = v
                        prv_e[w] = i
                        heapq.heappush(que, (r, w))
            if dist[t] == INF:
                return -1
            for i in range(N):
                H[i] += dist[i]
            d = f; v = t
            while v != s:
                d = min(d, G[prv_v[v]][prv_e[v]][1])
                v = prv_v[v]
            f -= d
            res += d * H[t]
            v = t
            while v != s:
                e = G[prv_v[v]][prv_e[v]]
                e[1] -= d # 順方向のキャパシティを削減
                G[v][e[3]][1] += d # 逆方向のキャパシティを増加
                v = prv_v[v]
        return res

N, M, F = map(int, input().split())
mcf = MinCostFlow(N)
for i in range(M):
    u, v, c, d = map(int, input().split())
    mcf.add_edge(u, v, c, d)
print(mcf.flow(0, N-1, F))
```

---

## 参考
 - [最小費用流問題 (Primal-Dual Algorithm)](https://tjkendev.github.io/procon-library/python/min_cost_flow/primal-dual.html)
