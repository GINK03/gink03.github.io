---
layout: post
title: "python sortedcontainers"
date: "2022-11-26"
excerpt: "pythonのsortedcontainersの使い方"
config: true
tag: ["python", "sortedcontainers", "b-tree"]
comments: false
sort_key: "2022-11-26"
update_dates: ["2022-11-26"]
---

# pythonのsortedcontainersの使い方

## 概要
 - python3の3.10には`dict`, `set`, `list`の木実装がなさそう
   - dictのキーやsetの値でbisect(二分探索)ができない
     - 値の探索、データの追加、削除が遅い
 - これらを補完する意味で、`sortedcontainers`がある
   - おそらく実装はB-tree
   - 二分探索をサポート
 - `add`, `remove`の速度が二分探索なので十分に早い

## インストール

```console
$ python3 -m pip install sortedcontainers
```

## SortedListの具体例

```python
from sortedcontainers import SortedList

lst = [1,5,9,1,5,9]
slst = SortedList(lst)
# slst; SortedList([1, 1, 5, 5, 9, 9])
assert list(slst) == sorted(lst)

assert(slst.bisect_left(5) == 2)
assert(slst.bisect_right(5) == 4)
```

## SortedDictの具体例

```python
from sortedcontainers import SortedDict
sd = SortedDict({2: "a", 1: "c", 3: "b"})

print(sd) # SortedDict({1: 'c', 2: 'a', 3: 'b'})
sd[0] = "z"
print(sd) # SortedDict({0: 'z', 1: 'c', 2: 'a', 3: 'b'})

assert(sd.bisect_left(1) == 1)
assert(sd.popitem() == (3, "b"))
```

---

## 参考
 - [Python Sorted Containers/Official](https://grantjenks.com/docs/sortedcontainers/)
 - [can Bisect be applied using Dict instead of lists?/StackOverflow](https://stackoverflow.com/questions/3099383/can-bisect-be-applied-using-dict-instead-of-lists)
