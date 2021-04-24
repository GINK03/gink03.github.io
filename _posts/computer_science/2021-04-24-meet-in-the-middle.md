---
layout: post
title: "meet in the middle"
date: 2021-04-24
excerpt: "半分全列挙について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "dynamic programming", "brute force", "meet in the middle"]
comments: false
---

# 半分全列挙(meet in the middle)について
 - 組み合わせの表現が爆発するとき、その表現を半分に分割して探索する
 - `X`の値を得たい時、プロセスAで`w`を作り、プロセスBで`X-w`を作るとこの結果の組み合わせが特定のパターンの探索になっている

## 具体的な例

`N`個の重さ`w_i`の品物を組合わせて`X`の重さを作る時、何通りあるか  

[もとの問題](https://atcoder.jp/contests/arc017/tasks/arc017_3)  

**入力**  
```
N X
w_1
w_2
.
.
.
w_n
```

```
5 5
1
1
2
3
4
```

*コード*
```python
from collections import defaultdict

N, X = list(map(int, input().split()))

A = []
B = []

for i in range(N):
    w = int(input())
    if i % 2 == 0:
        A.append(w)
    else:
        B.append(w)


def has_bit(n, i):
    return (n & 1 << i) > 0


dic = defaultdict(int)

for n in range(1 << len(B)):
    w = 0
    for i in range(N):
        if has_bit(n, i):
            w += B[i]
    dic[w] += 1


ans = 0
for n in range(1 << len(A)):
    w = 0
    for i in range(N):
        if has_bit(n, i):
            w += A[i]
    ans += dic[X - w]

print(ans)
```
