---
layout: post
title: "warshall-floyd"
date: 2021-04-25
excerpt: "ワーシャル-フロイド法について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "network", "graph", "warshall-floyd", "floyd-warshall", "ワーシャル-フロイド法"]
comments: false
sort_key: "2021-07-11"
update_dates: ["2021-07-11","2021-06-04","2021-05-21","2021-04-25"]
---

# ワーシャル-フロイド法について
 - 英名は`floyd-warshall`
 - 重み付き有方向グラフのすべてのノードの最短経路を解くアルゴリズム
   - すべての辺からのアクセスを仮定しその最小値を取得する
 - 計算量`O(V^3)`であり、すべてのノードの最短距離を計算するときはダイクストラ方より早い
   - であると思ったが問題によってはダイクストラのほうが早かった
 - 負の閉路を含むかどうかの判定に用いることができる
 - CPPだと割と早いが、pythonだと壊滅的に遅いのでワーシャルフロイド法を試すようなケースの際は、CPPを選ぶと良い

---

### 例; pythonでは間に合わないがCPPで余裕で間に合う例

**問題**  
 - [AtCoder Beginner Contest 208; D - Shortest Path Queries 2](https://atcoder.jp/contests/abc208/tasks/abc208_d)

**解答**  
```python
int main() {
    int N, M; cin >> N >> M;
    auto G = mk_mat<ll>(N, N, INF);
    rep(m, M) {
        int u, v, c; cin >> u >> v >> c;
        u-=1; v-=1;
        G[u][v] = c;
    }
    // 同じノード上の距離は0とする
    rep(i, N) {
        G[i][i] = 0;
    }

    ll acc = 0;
    // ワーシャルフロイド法
    rep(k, N) {
      rep(x, N) {
        rep(y, N) {
          G[x][y] = min(G[x][y], G[x][k] + G[k][y]);
          if(G[x][y] != INF) acc += G[x][y];
        }
      }
    }
    print(acc)
}
```

---

### 例; 全点対最短経路問題

**問題**  
 - [典型アルゴリズム問題集; E - 全点対最短経路問題](https://atcoder.jp/contests/typical-algorithm/tasks/typical_algorithm_e)


**解答**  
```python
import math

N, M = map(int, input().split())

G = [[float("inf")] * N for _ in range(N)]
for _ in range(0, M):
    u, v, c = map(int, input().split())
    G[u][v] = c

# 同じノード上の距離は0とする
for i in range(0, N):
    G[i][i] = 0

# ワーシャルフロイド法
for k in range(0, N):
    for x in range(0, N):
        for y in range(0, N):
            G[x][y] = min(G[x][y], G[x][k] + G[k][y])


# すべての頂点の組について最短距離を計算する
ans = 0
for i in range(0, N):
    for j in range(0, N):
        ans += G[i][j]

print(ans)
```

## 例; 負の閉路を含むワーシャルフロイド  
**問題**  
 - [All Pairs Shortest Path](https://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_1_C&lang=ja)  

**解説**  
 - 負の閉路を含む状態とは自分自身の参照がマイナスになる結果がワーシャルフロイドによって得られることである  

**解答**  
```python
import math

N, M = map(int, input().split())
G = [[math.inf] * N for _ in range(N)]

for _ in range(0, M):
    u, v, c = map(int, input().split())
    G[u][v] = c

# 同じノード上の距離は0とする
for i in range(0, N):
    G[i][i] = 0

# ワーシャルフロイド法
for k in range(0, N):
    for x in range(0, N):
        for y in range(0, N):
            G[x][y] = min(G[x][y], G[x][k] + G[k][y])

# 負の閉路(negative cycle)を検出
flag = False
for i in range(N):
    if G[i][i] < 0:
        flag = True

if flag:
    print("NEGATIVE CYCLE")
else:
    for elms in G:
        print(*[elm if elm != math.inf else "INF" for elm in elms])
```

---

###  例; 他に最短経路がないかを観測してその他の経路を観測する例  

**問題**  
 - [AtCoder Beginner Contest 074; D - Restoring Road Network](https://atcoder.jp/contests/abc074/tasks/arc083_b)  

**解説**  
 - 題意を把握するのがすごく大変であった  
 - 意味としては、最短経路になる外の通路の候補があったとき、それの和を求めたい、みたいなイメージ  

**解答**  

```python
# 問題文の意図を読み取るのがすごい大変だった
import copy
N=int(input())
B=[list(map(int,input().split())) for _ in range(N)]

G = copy.deepcopy(B)

xys = set()
# ワーシャルフロイド法
for k in range(0, N):
    for x in range(0, N):
        for y in range(0, N):
            # 別の道路による最短経路の組み合わせがあるということ
            if x!=k and y != k and G[x][y] == G[x][k] + G[k][y]:
                xys.add( (x,y) )
            G[x][y] = min(G[x][y], G[x][k] + G[k][y])

if B != G:
    print(-1)
else:
    ans = 0
    for x in range(N):
        for y in range(N):
            if not (x, y) in xys:
                ans += G[x][y]
    print(ans//2)
```
