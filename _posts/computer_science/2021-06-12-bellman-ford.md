---
layout: post
title: "bellman-ford algorithm"
date: 2021-06-12
excerpt: "ベルマンフォード法について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "minimum", "graph"]
comments: false
sort_key: "2021-07-11"
update_dates: ["2021-07-11","2021-06-19","2021-06-12"]
---

# ベルマンフォード法について
 - 最短経路を探索するアルゴリズム
 - dijkstraより計算コストは重いが、ワーシャルフロイドよりは軽い
   - 重いのでCPPを検討しても良い
 - 負の値を辺が持っていても矛盾を起こさないためそこはいいかもしれない
   - その代わり、接続されていない独立した木などを区別できないので矛盾を起こす
 - 負閉路を検出することができる
 - 最短経路の判定問題にも用いることができ、線形計画問題において、解がある時、`f(s) = 0`となるはずであるが、`f(s) < 0`になる、つまり、負閉路があれば解はない
   - 牛ゲーなどと呼ばれる
   - [参考](https://ei1333.github.io/luzhiled/snippets/memo/ushi-game.html)

## 具体的なコード(python)

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

--- 

### 具体的なコード(CPP)

```cpp
int N, Q;
vector<tuple<int,int,int>> G;

vector<ll> bellman_ford(int s, int N) {
  auto d = mk_vec<ll>(N, INF);
  d[s] = 0;
  rep(n, N) {
        bool update = false;
        rep(pos, G.size()){
          int i, j, c; tie(i, j, c) = G[pos];
          if(d[j] > d[i] + c) {
                  d[j] = d[i] + c;
                  update = true;
          }
        }
        // 負閉路が存在する場合、空のベクターを返す
        if(update == false) {
          return vector<ll>();
        }
  }
  return d;
}

int main() {
  cin >> N >> Q;
  rep(n, N-1) {
        int i, j;
        cin >> i >> j;
        i -= 1; j -=1;
        G.push_back(make_tuple(i, j, 1));
        G.push_back(make_tuple(j, i, 1));
  }
  vector<ll> dv = bf(0, N);
  rep(q, Q) {
        int c,d; cin >> c >> d; c -= 1; d -=1;
        int r = abs(dv[d] - dv[c]);
        if(r%2 == 0) {
          print("Town");
        } else {
          print("Road");
        }
  }
  return 0;
}
```
 - [AtCoder Beginner Contest 209; D - Collision](https://atcoder.jp/contests/abc209/tasks/abc209_d)
 
---

### 例; 閉路を検出しつつラベル付けする

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

--- 

### 例; 牛ゲー

**問題**  
 - [東京大学プログラミングコンテスト2013; H - Asteroids2](https://atcoder.jp/contests/utpc2013/tasks/utpc2013_08)

**解説**  
 - 牛ゲーの典型
 - 制約がある時、順方向を上界の値を使ったネットワーク、逆方向を下界の値を使ったネットワークを定義することで解くことができる
 - この問題では単純に解があるかどうか ≡ 負閉路を含まないかどうかを問うている

**解答**  

```python
N,M=map(int,input().split())
 
*P,=map(int,input().split())
*Q,=map(int,input().split())
 
XYAB = []
for _ in range(M):
    xyab = list(map(int,input().split()))
    XYAB.append(xyab)
 
G = []
for i, p in enumerate(P):
    G.append( (2*N, i, p) )
    G.append( (i, 2*N, 0) )
 
for i, q in enumerate(Q):
    G.append( (2*N, i+N, 0) )
    G.append( (i+N, 2*N, q) )
 
for x,y,a,b in XYAB:
    x -= 1;
    y += N-1
    G.append( (x, y, -a) )
    G.append( (y, x, b) )
 
 
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
 
        if d[-1] != 0:
            return "no"
    return "yes"
 
d = bellman_ford(2*N, N=2*N+1)
print(d)
```
