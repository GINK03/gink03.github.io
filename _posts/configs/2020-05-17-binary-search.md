---
layout: post
title: "binary-search"
date: 2020-05-17
excerpt: "binary-search"
tags: [binary-search]
config: true
comments: false
---

# binary-search

解析的に求められない何らかの値を高速に求める

## 解析的説明
コンピュータを使った数値範囲は、`2**32` つまり `[0, 2^32)` にたいてい限定されることを利用して、中央値をサンプルして、閾値以上、閾値以下でサンプル範囲を限定していく。  

これを32回、繰り返せば実質的に、すべてのint範囲について最適な値が求まっているはずである

## サンプルコード
ある関数が正か負かで探索回数を200回限定する（答えが小数点以下であるような値でも近似値を求めることができる） 

ただし、範囲は `[0, 10**12]` であることに注意

```python
import math
p,q=map(int,input().split())

def f(x):
    return x*x - q*x*math.log2(x) - p

l,r=0,10**12
for _ in range(200):
    mid_x = (l+r)/2
    if f(mid_x) >= 0:
        r = mid_x
    else:
        l = mid_x

print(mid_x)
```


## 参考資料
 - https://maspypy.com/yukicoder-no1042-愚直大学
 - https://yukicoder.me/problems/no/1042 : 上記サンプルコードの例




