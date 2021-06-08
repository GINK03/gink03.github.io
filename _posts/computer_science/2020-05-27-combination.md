---
layout: post
title: "combination"
date: 2020-05-27
excerpt: "combinationの様々な実装方法"
computer_science: true
tags: ["アルゴリズム", "combination"]
comments: false
---

# combinationの計算の仕方

## scipy, mathのcombination

**scipy**  
```python
from scipy.special import comb
print(comb(10, 7)) # 120.0
```

**math**  
```python
import math
math.comb(10,7) # 120
```

## mod付きcombination
最速である  
```python
mod = 10 ** 9 + 7
def mod_cmb(n, a, mod):
    nca = 1
    for i in range(a):
        nca *= (n - i) * pow(a - i, mod - 2, mod)
        nca %= mod
    return nca
print(mod_cmb(10, 7, mod)) # 120
```

---

# combination with replacement
重複許可のcombination
 - 選択される要素が排反的でない
 - 特に、動的なリスト等を作成して、フィルターにするなどはアルゴリズム的にも計算量的にも大変重いので、これを使わないと解けないなどがある

## 具体例

以下の問題ではメモリの制約が薄ければ、問題なく解けるものであるが、このサイズのメモリを許容できないことによって、`combination_with_replacement` が実質的に必要になっている

 - https://atcoder.jp/contests/abc165/tasks/abc165_c

**NG** 
```python
# このアプローチはメモリーエラー
s=[[1]]
 
#長さNまで
import copy
while True:
    n = []
    for s1 in s:
        for append in range(s1[-1], M+1):
            n1 = copy.copy(s1)
            n1.append(append)
            n.append(n1)
    if len(n[0]) > M:
        break
    s = n
#for s1 in s:
#    print(s1)
iidp = [list(map(int,input().split())) for q in range(Q)]
 
al = 0
for s1 in s:
    a = 0
    for i1, i2, d, p in iidp:
        if s1[i2-1] - s1[i1-1] == d:
            a += p
    al = max(a,al)
 
print(al)
```

**OK**  
```python
N,M,Q=map(int,input().split())
iidp = [list(map(int,input().split())) for q in range(Q)]
import itertools
al = 0
for s1 in itertools.combinations_with_replacement(list(range(1,M+1)), N):
    a = 0
    for i1, i2, d, p in iidp:
        if s1[i2-1] - s1[i1-1] == d:
            a += p
    al = max(a,al)
print(al)
```
