---
layout: post
title: "coordinate compression"
date: 2021-04-28
excerpt: "座標圧縮について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "binary-search"]
comments: false
sort_key: "2021-04-28"
update_dates: ["2021-04-28"]
---

# 座標圧縮(coordinate compression)について
 - データサイエンスのrankに該当する概念
 - 二分探索を使うことで`O(n log n)`する

## pythonによる例

```python
import bisect
L = [55, 6, 432, 55, 98, 67, 6, 32]

v = sorted(list(set(L)))

rank = []
for l in L:
    rank.append(bisect.bisect_left(v, l))

print(L)
print(rank)
```

```console
$ python3 a.py
[55, 6, 432, 55, 98, 67, 6, 32]
[2, 0, 5, 2, 4, 3, 0, 1]
```
