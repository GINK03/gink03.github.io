---
layout: post
title: "digit dp charactor(binary)"
date: 2021-05-30
excerpt: "桁DP(binary or 文字列)について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "math", "dp", "digit-dp", "binary", "charactor"]
comments: false
sort_key: "2021-12-30"
update_dates: ["2021-12-30"]
---

# 桁DP(binary or 文字列)について
 - 桁dpのシンプル版の文字列またはbinaryに適応可能な例
 - 少ないサンプルをcolabで作成して実験するとわかりやすい

## colab
 - [colab](https://colab.research.google.com/drive/1djlRAgLR3lqpQDHL7iFpOgJVF_mrrob5?usp=sharing)

---

## 例; "a"がA個, "b"がB個からなるN字の文字列は何通りあるか

```python
A = 5
B = 3

AS = "a"*A
BS = "b"*B

# 愚直
a = set()
for c in itertools.permutations(list(AS+BS), len(AS+BS)):
    a.add("".join(c))
print(len(a)) # 56

# 解析的解
scipy.special.comb(A+B, B) # 56.0

# 桁dpによる解
import numpy as np
## a,b 0 -> 1と考えられる

## Aが30,Bが30まであるとき
dp = np.zeros((30,30)).astype(int)
dp[0][0] = 1
for ai in range(30):
    for bi in range(30):
        if ai > 0:
            dp[ai][bi] += dp[ai-1][bi]
        if bi > 0:
            dp[ai][bi] += dp[ai][bi-1]
print(dp[A][B]) # 56
```

---

## 例; "a"がA個, "b"がB個, "c"がC個からなるN字の文字列は何通りあるか

```python
A = 3
B = 3
C = 4

AS = "a"*A
BS = "b"*B
CS = "c"*C

# 愚直
a = set()
for c in itertools.permutations(list(AS+BS+CS), len(AS+BS+CS)):
    a.add("".join(c))
print(len(a)) # 4200

# 桁DP
## Aが10, Bが10, Cが10まであるとき
dp = np.zeros((10,10, 10)).astype(int)
dp[0][0][0] = 1
for ai, bi, ci in itertools.product(range(10), range(10), range(10)):
            if ai > 0:
                dp[ai][bi][ci] += dp[ai-1][bi][ci]
            if bi > 0:
                dp[ai][bi][ci] += dp[ai][bi-1][ci]
            if ci > 0:
                dp[ai][bi][ci] += dp[ai][bi][ci-1]
print(dp[A][B][C]) # 4200
```

---

## 例; aとbの文字からなる文字列のうち、K番目の文字列が知りたい

**問題**  
 - [AtCoder Beginner Contest 202; D - aab aba baa](https://atcoder.jp/contests/abc202/tasks/abc202_d)

**解説**  
 - 戻すdpの側面がある
 - まず、あり得る組み合わせをdpで求める
 - 次に、メモ化再帰を使い、状態を確定させていく

**解答**  

```python
import math
import itertools
import collections
# 桁dpを構築
# https://gink03.github.io/digit-dp-charactor/
dp = collections.defaultdict(int)
dp[(0,0)] = 1

for a, b in itertools.product(range(31), range(31)):
    dp[(a+1, b)] += dp[(a,b)]
    dp[(a,b+1)] += dp[(a,b)]

def dfs(a, b, k):
    if a == 0:
        return "b"*b
    elif b == 0:
        return "a"*a
    elif k <= dp[(a-1, b)]:
        return "a" + dfs(a-1, b, k)
    else:
        return "b" + dfs(a, b-1, k-dp[(a-1,b)])

A,B,K=map(int,input().split())
print(dfs(A,B,K))
```
