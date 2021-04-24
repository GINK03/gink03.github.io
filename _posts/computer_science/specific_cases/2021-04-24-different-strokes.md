---
layout: post
title: "[specific]diffrenet strokes"
date: 2021-04-24
excerpt: "greedyアルゴリズムの特殊系"
computer_science: true
hide_from_post: true
specific: true
tag: ["algorithm", "graph"]
comments: false
---

# greedyアルゴリズムの特殊系
 - どの軸でsortすればよいのか不明な時
 - どういう状態が嬉しいのか定義する
 - 例えば幸福度(A, Bがある)の差がある時
   - `i < j`の時
   - `A_i - B_j > A_j - B_i`が成立してほしい
	 - `A_i + B_i > A_j + B_j`と変形できる
	   - `A_i + B_i`がソート軸

## 回答

[全国統一プログラミング王決定戦予選; C - Different Strokes](https://atcoder.jp/contests/nikkei2019-qual/tasks/nikkei2019_qual_c)  

```python
N = int(input())
P = []
for i in range(N):
  a,b = list(map(int, input().split()))
  P.append([a+b,a,b])

P.sort(reverse=True)
a = sum([p[1] for i,p in enumerate(P) if i%2==0])
b = sum([p[2] for i,p in enumerate(P) if i%2==1])
print(a-b)
```
