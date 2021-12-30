---
layout: post
title: "travelling salesman"
date: 2021-04-23
excerpt: "巡回セールスマン問題について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "dynamic programming", "travelling salesman"]
comments: false
---

# 巡回セールスマン問題について
 - 解析的に特のは難しい問題とされるが、`O(n^3)`で解くことが可能である
 - bitパターンにして計算すればどうにかなる、というときにこのソリューションを用いることができる
   - 一般的にbit dpと呼ばれる方法
 - 方法として美しかったのでまとめる


## 例; ビット演算を使った動的計画法で解く

**オンラインでの問題**
 - [C - 巡回セールスマン問題](https://atcoder.jp/contests/typical-algorithm/tasks/typical_algorithm_c)

**入力**
```
4
0 3 1 4
1 0 5 9
2 6 0 5
3 5 8 0
```

このマトリックスの数字がある都市から都市に移動するコストである

**解き方**

```python
import math

N = int(input())
A = []
for i in range(N):
    a = list(map(int, input().split()))
    A.append(a)

ALL = 1 << N

cost = []
for n in range(ALL):
    cost.append([math.inf] * N)

cost[0][0] = 0


def has_bit(n, i):
    return n & (1 << i) > 0


for n in range(ALL):
    for i in range(N):
        for j in range(N):
            if has_bit(n, j) or i == j:
                continue
            cost[n | (1 << j)][j] = min(cost[n | (1 << j)][j], cost[n][i] + A[i][j])

print(cost[ALL - 1][0])
```

## 例; bit dpとして解く
**問題**  
[Traveling Salesman Problem](https://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=DPL_2_A)  
**解答**  
```python
import math

N,M = map(int,input().split())

STV = []
for m in range(M):
    s,t,v = list(map(int, input().split()))
    STV.append( (s,t,v) )

ALL = 1 << N
cost = []
for n in range(ALL):
    cost.append([math.inf] * N)
cost[0][0] = 0

def has_bit(n, i):
    return n & (1 << i) > 0

for n in range(ALL):
    for s, t, v in STV:
        # 宛先がすでに探索済みリストにいるとき or
        # 今いるところと宛先が同じ場合はキャンセル
        if has_bit(n, t) or s == t:
            continue
        # tビットを立てて更新する
        cost[n|(1<<t)][t] = min(cost[n|(1<<t)][t], cost[n][s] + v)

if cost[ALL-1][0] == math.inf:
    print(-1)
else:
    print(cost[ALL - 1][0])
```
