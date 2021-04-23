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
 - 方法として美しかったのでまとめる


## ビット演算を使った動的計画法で解く

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

