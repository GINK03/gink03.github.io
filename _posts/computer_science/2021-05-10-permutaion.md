---
layout: post
title: "permutaion"
date: 2021-05-10
excerpt: "permutaionについて"
computer_science: true
hide_from_post: true
tag: ["algorithm", "math", "permutaion", "integer"]
comments: false
---

# permutaionについて

## フルスクラッチによる実装  

```python
from typing import Optional, List

def permute(a: List, l: int, r: int) -> Optional[List]:
    if l==r:
        yield a
    else:
        for i in range(l,r+1):
            a[l], a[i] = a[i], a[l]
            yield from permute(a, l+1, r)
            a[l], a[i] = a[i], a[l] # もとに戻す
        None

a = list(range(10))
n = len(a)
gen = permute(a, 0, n-1)
print(next(gen)) # [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
print(next(gen)) # [0, 1, 2, 3, 4, 5, 6, 7, 9, 8]
print(next(gen)) # [0, 1, 2, 3, 4, 5, 6, 8, 7, 9]
```
 - [google colab](https://colab.research.google.com/drive/1w0FAqbNfLEN8b7zoXYVed7Yx5fxXFvvz?usp=sharing)


## ライブラリの速度とスクラッチによる速度の差

圧倒的にライブラリのほうが速度が早い  

***1 loop, best of 5: 231 ms per loop***
```python
%%timeit
from itertools import permutations
a = list(range(10))
for i in permutations(a):
    pass
```

***1 loop, best of 5: 5.54 s per loop***
```python
%%timeit
a = list(range(10))
n = len(a)
for i in permute(a, 0, n-1):
    pass
```

