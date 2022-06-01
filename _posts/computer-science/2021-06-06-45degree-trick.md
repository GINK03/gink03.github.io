---
layout: post
title: "45 degree trick"
date: 2021-06-06
excerpt: "マンハッタン距離の45°回転について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "math"]
comments: false
sort_key: "2021-06-12"
update_dates: ["2021-06-12","2021-06-06"]
---

# マンハッタン距離の45°回転について
 - マンハッタン距離の特徴として距離の比較を行うことが難しい
 - 45°回転することで距離が遠いか近いかの計算ができるようになる

## 具体的計算
`(x,y)`の値があるときに、`(x+y, x-y)`が45°回転した値である  

## イメージ

```python
xy = []
for i in range(1000):
    x = random.randint(0, 10)
    y = random.randint(0, 10)
    xy.append( (x, y) )

df = pd.DataFrame(xy)
df.columns = ["x", "y"]

# 45度回転
df["X"] = df["x"] + df["y"]
df["Y"] = df["x"] - df["y"]

plt.figure(figsize=(15, 15)) # ここを大きくする
ax = sns.scatterplot(data=df, x="x", y="y")
ax = sns.scatterplot(data=df, x="X", y="Y")
ax
```

<div>
  <img src="https://user-images.githubusercontent.com/4949982/120921761-2931f780-c700-11eb-9f31-ff354defd4a1.png">
</div>

 - [colab](https://colab.research.google.com/drive/1buBQ9hC9M45r-QKgKZSOebkYIGeakMEI?usp=sharing)


## 例; マンハッタン距離の最大値を求める

**問題**  
 - [競プロ典型 90 問; Max Manhattan Distance](https://atcoder.jp/contests/typical90/tasks/typical90_aj)

**解説**  
 - マンハッタン距離の差が、45°回転した距離の差に一致することを利用して最大最小を計算する

**解答**  
```python
import collections
N,Q=map(int,input().split())

A = []
E = collections.namedtuple("E", ["X", "Y", "x", "y"])

for _ in range(N):
    x,y=map(int,input().split())
    A.append(E(X=x+y, Y=y-x, x=x, y=y))

minX, minY = min(map(lambda x:x.X, A)), min(map(lambda x:x.Y, A))
maxX, maxY = max(map(lambda x:x.X, A)), max(map(lambda x:x.Y, A))

for q in range(Q):
    qi = int(input())-1
    qX, qY, qx, qy = A[qi]
    cans = [abs(qX-minX), abs(qX-maxX), abs(qY-minY), abs(qY-maxY)]
    print(max(cans))
```
