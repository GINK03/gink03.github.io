---
layout: post
title: "python bisect"
date: 2020-04-11
excerpt: "pythonのbisectの使い方"
tags: ["python", "bisect", "binary search"]
config: true
comments: false
sort_key: "2020-04-11"
update_dates: ["2020-04-11"]
---

# pythonのbisectの使い方
 - `binary search`をするライブラリ
 - これらを便利にラップしたものが、[/python-sortedcontainers/](/python-sortedcontainers/)

## 具体例

### 基本(bisect_left, bisect_right)

```python
import bisect
import random

l = random.sample(list(range(0, 10**5)), 10**4)
random.shuffle(l)

"""
 - bisect_left
   - sortされたlistで左から探して挿入できる点を探す
 - bisect_right
   - sortされたlistで右から探して挿入できる点を探す
"""
l.sort()
for th in random.sample(list(range(0, 10**5)), 100):
    idx = bisect.bisect_left(l, th)
    print(f'idx={idx}, th={th}, prev_value={l[idx]}' )
```

### 挿入(insort_left)
 - `binary search`を行って値も挿入する
   - `bisect_left` + `insert`よりわずかに効率がいい
 - `sortedcontainers`の`SortedList`と同等の機能を実装できる

```python
sl = [1, 3, 5]
bisect.insort_left(sl, 4)
print(sl) # [1, 3, 4, 5]
```

---

## 参考
 - [bisect — Array bisection algorithm/docs.python.org](https://docs.python.org/3/library/bisect.html)
