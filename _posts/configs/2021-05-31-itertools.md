---
layout: post
title: "itertools"
date: 2021-05-31
excerpt: "itertools(python3)チートシート"
tags: ["python", "itertools", "チートシート"]
config: true
comments: false
---

# itertools(python3)チートシート


## accumulate

```python3
import itertools
arr = [1, 3, 5, 7, 9]
cumsum = itertools.accumulate(arr)
print(*cumsum) # 1 4 9 16 25
```

## combinations

```python
import itertools
arr = [1, 3, 5,]
ptns = itertools.combinations(arr, 2)
print(*ptns) # (1, 3) (1, 5) (3, 5)
```

## combinations_with_replacement
重複を許可する  

```python
import itertools
arr = [1, 3, 5,]
ptns = itertools.combinations_with_replacement(arr, 2)
print(*ptns) # (1, 1) (1, 3) (1, 5) (3, 3) (3, 5) (5, 5)
```
 - この実装は[dfsを用いた方法でも再現](https://atcoder.jp/contests/abc165/submissions/23133750)できる

## permutations

```python
import itertools
arr = [1, 3, 5,]
ptns = itertools.permutations(arr, 2)
print(*ptns) # (1, 3) (1, 5) (3, 1) (3, 5) (5, 1) (5, 3)
```

## product

repeatを用いる例  

```python
import itertools
arr = [1, 3, 5,]
ptns = itertools.product(arr, repeat=2)
print(*ptns) # (1, 1) (1, 3) (1, 5) (3, 1) (3, 3) (3, 5) (5, 1) (5, 3) (5, 5)
```

複数の要素をクロスさせる例  
for文のネストをflattenできるので便利

```python
import itertools
ptns = itertools.product([1,2,3], ["a", "b"], [True, False])
print(*ptns) # (1, 'a', True) (1, 'a', False) (1, 'b', True) (1, 'b', False) (2, 'a', True) (2, 'a', False) (2, 'b', True) (2, 'b', False) (3, 'a', True) (3, 'a', False) (3, 'b', True) (3, 'b', False)
```

## count
カウンター付き無限ループ

```python
import itertools
for i in itertools.count(10):
    if i > 20:
        break
    print(i, end=" ") # 10 11 12 13 14 15 16 17 18 19 20 
```

## repeat

```python
import itertools
for i in itertools.repeat(11, 3):
    print(i, end=" ") # 11 11 11 
```

## starmap
mapの複数引数版  

```python
import itertools
print(*itertools.starmap(lambda l,m,r: l**m + r, [(2,2, 1), (2,3, 0), (3,3, 0)])) # 5 8 27
# print(*map(lambda l,r: l**r, [(2,2), (2,3), (3,3)])) -> mapは引数を一個のみ
```
