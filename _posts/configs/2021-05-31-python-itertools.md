---
layout: post
title: "itertools"
date: 2021-05-31
excerpt: "itertools(python3)チートシート"
tags: ["python", "itertools", "チートシート"]
config: true
comments: false
sort_key: "2021-06-05"
update_dates: ["2021-06-05","2021-06-03","2021-05-31"]
---

# itertools(python3)チートシート


## accumulate
 - 累積和を得る(numpyには累積積もある)  

```python
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
 - 重複を許可したコンビネーション

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
 - repeatを用いる例  

```python
import itertools
arr = [1, 3, 5,]
ptns = itertools.product(arr, repeat=2)
print(*ptns) # (1, 1) (1, 3) (1, 5) (3, 1) (3, 3) (3, 5) (5, 1) (5, 3) (5, 5)
```

 - 複数の要素をクロスさせる例  
 - for文のネストをflattenできるので便利

```python
import itertools
ptns = itertools.product([1,2,3], ["a", "b"], [True, False])
print(*ptns) # (1, 'a', True) (1, 'a', False) (1, 'b', True) (1, 'b', False) (2, 'a', True) (2, 'a', False) (2, 'b', True) (2, 'b', False) (3, 'a', True) (3, 'a', False) (3, 'b', True) (3, 'b', False)
```

## groupby
 - pandasのgroupbyなどとは異なる挙動なので注意  
 - 連続するグループごとに集計することができる  

```python
bin_lst = [random.choice([0, 1]) for i in range(20)]
print(bin_lst) # [0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1]

for gk, viter in itertools.groupby(bin_lst):
    print(gk, list(viter))
# 0 [0, 0, 0]
# 1 [1, 1]
# 0 [0, 0]
# 1 [1, 1, 1, 1, 1]
# 0 [0, 0, 0, 0, 0, 0, 0]
# 1 [1]
```

**keyを指定する場合**

```python
import itertools
data = [(0, "a"), (0, "b"), (1, "c"), (1, "d"), (0, "e")]

for grp_key, iters in itertools.groupby(data, key=lambda x:x[0]):
    print(grp_key, list(iters))
"""
0 [(0, 'a'), (0, 'b')]
1 [(1, 'c'), (1, 'd')]
0 [(0, 'e')]
"""
```

## count
 - カウンター付き無限ループ

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
 - mapの複数引数版  

```python
import itertools
print(*itertools.starmap(lambda l,m,r: l**m + r, [(2,2, 1), (2,3, 0), (3,3, 0)])) # 5 8 27
# print(*map(lambda l,r: l**r, [(2,2), (2,3), (3,3)])) -> mapは引数を一個のみ
```

## zip_longest
 - 長い方に合わせたzip
 - 短いほうが不足する場合、埋める値を指定できる

```python
import itertools
def solve(v1, v2):
    lst = []
    for a1, a2 in itertools.zip_longest(v1, v2, fillvalue=None):
        lst.append((a1, a2))
    return lst

print(solve([1, 2], [3,4,5,6])) # [(1, 3), (2, 4), (None, 5), (None, 6)]
```

