---
layout: post
title: "extended euclidean algorithm"
date: 2021-05-13
excerpt: "拡張ユークリッド互除法について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "math", "integer"]
comments: false
---

# 拡張ユークリッド互除法について
`ax + by = c`が整数`a`, `b`, `c`を求める必要がある場合、必ず`a`と`b`の最大公約数`g`の倍数に`c`はなる  

つまり、少なくとも１つの値`x`, `y`で以下が成立する  

$$
ax + b y = k gcd(a,b)
$$

## pythonでの実装例

**再帰を使う**  
```python
def egcd(a, b):
    # Base Case
    if a == 0 : 
        return b, 0, 1
    gcd, x1, y1 = egcd(b%a, a)
    # Update x and y using results of recursive
    # call
    x = y1 - (b//a) * x1
    y = x1
    return gcd, x, y
```

**再帰を使わない**  
```python
def egcd(a,b):
    x, y, u, v = 1, 0, 0, 1
    while b:
        k = a // b
        x -= k * u
        y -= k * v
        x, u = u, x
        y, v = v, y
        a, b = b, a % b
    return x, y
```
 - [colab](https://colab.research.google.com/drive/1_2g3FX6_9aon2LgHBFC0wdqkQ4aKNHjc?usp=sharing)
