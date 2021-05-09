---
layout: post
title: "bit operation"
date: 2021-04-22
excerpt: "bit operationについて"
computer_science: true
hide_from_post: true
tag: ["bit operation"]
comments: false
---

# bit operationについて
pythonでも高速にbit operationを行うことができる  
bit全探索等の広い応用先がある  

## 演算

### &

```python
2 & 6 
=> 2
```

### | 

```python
2 | 6
=> 6
```

### <<

`2^k`するのと同義  
bit列で考えると、左にシフトするのと同義  

```python
3 << 2
=> 12
```

### >>

`2^k`で割り込むのと同義  
bit列で考えると、右にシフトするのと同義  

```python
12 >> 2
=> 3
```

## 応用; bit列の共起

`n`の整数で表されるbit列に要素`i`が含まれるかどうかを判定する

```python
def has_bit(n, i):
  return (n & (1<<i) > 0)
```

## 応用; bit全探索

brute-forceで`n`個の要素があり`n!`個のパターンを試行する必要がある場合に高速に演算できる  

例えば、`[1,-2,3,-4,5,-6,7,-8,9,-10,11,-12]`の列のどの要素を合計すると最大になるか探索する場合  

```python
import math
A = [1,-2,3,-4,5,-6,7,-8,9,-10,11,-12]
size = len(A)

ans = -math.inf
all_pattern = 1<<size
for i in range(all_pattern):
    acc = 0
    for j in range(len(A)):
        if i&(1<<j) != 0:
            acc += A[j]
    ans = max(ans, acc)
print(ans) # 36, print(sum([a for a in A if a >= 0]))と等しくなる
```

## 10進数を2進数のリストに変換する

```python
>>> n = 10
>>> b = [n >> i & 1 for i in range(n.bit_length()-1,-1,-1)]
>>> b
[1, 0, 1, 0]
```

## 2進数のリストを10進数に変換する

```python
>>> b
[1, 0, 1, 0]
>>> [(x * 1<<i) for i, x in enumerate(reversed(b))]
[0, 2, 0, 8]
>>> sum([(x * 1<<i) for i, x in enumerate(reversed(b))])
10
```
