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

## &

```python
2 & 6 
=> 2
```

## | 

```python
2 | 6
=> 6
```

## <<

`2^k`するのと同義

```python
3 << 2
=> 12
```

## >>

`2^k`で割り込むのと同義

```python
12 >> 2
=> 3
```

## 応用

`n`の整数で表されるbit列に要素`i`が含まれるかどうかを判定する

```python
def has_bit(n, i):
  return (n & (1<<i) > 0)
```

