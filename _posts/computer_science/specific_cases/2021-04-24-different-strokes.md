---
layout: post
title: "[specific]diffrenet strokes"
date: 2021-06-07
excerpt: "greedyアルゴリズムの特殊系"
computer_science: true
hide_from_post: true
specific: true
tag: ["algorithm", "greedy"]
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

## 例; 相手にペナルティを与える かつ 自分が利益を得る とき 
**問題**  
 - [AtCoder Beginner Contest 187; D - Choose Me](https://atcoder.jp/contests/abc187/tasks/abc187_d)
**考察**  
 - `自分の利益` - `相手へのペナルティ` = `greedyで取るべき順`
**解答**  
 - [提出](https://atcoder.jp/contests/abc187/submissions/23272272)

## 例; 相手にペナルティを与える かつ 自分が利益を得る とき(その２)

**問題**  
 - [全国統一プログラミング王決定戦予選; C - Different Strokes](https://atcoder.jp/contests/nikkei2019-qual/tasks/nikkei2019_qual_c)  

**解答**  
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

## 例; 0より大きいか小さいかで２つのグループに分けられるとき 

**問題**  
 - [AtCoder Regular Contest 053; C - 魔法使い高橋君](https://atcoder.jp/contests/arc053/tasks/arc053_c)

**考察**  
 - グループを作成
   - 温度を結果的に下げるグループをL
   - 温度を結果的に上げるグループをR
 - greedyの処理
   - greedy的に考えると、Lはaが小さいものから入れていけば良い
   - Rはbが大きいものから入れていけば良い
   - Lが最初でRが次
**解答**  
 - [提出](https://atcoder.jp/contests/arc053/submissions/23273202)
