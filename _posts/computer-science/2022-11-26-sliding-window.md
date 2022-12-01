---
layout: post
title: "sliding window"
excerpt: "sliding windowする際の高速な計算"
tag: ["アルゴリズム", "sliding window"]
date: 2022-11-26
computer_science: true
comments: false
sort_key: "2022-11-26"
update_dates: ["2022-11-26"]
---

# sliding windowする際の高速な計算

## 概要
 - sliding windowをlist(linked list)のようなもので切り出すとその切り出した内容を処理するのは遅い
   - windowsの中に特定の値が含まれるかは`O(n * k)`になる
   - windowsの中でソートすると`O(n lon n * k`になり、実用的ではない
 - windowを構築する際に、[/B木/](/B木/)で切り出していくとwindowの中を様々に処理できる
   - sortが必要な操作
   - 二分探索が必要な操作
   - 値の存在の判定

## 具体例

### sliding windowで、window内の最大値を計算する
 - 概要
   - max関数を都度呼ぶのは無理
   - B木の`SortedList`を用いると、最大値は末尾になるので計算が必要ない

```python
from sortedcontainers import SortedList

def solve(nums, k):
    window = SortedList()
    ret = []
    for i, n in enumerate(nums):
        if len(window) < k:
            window.add(n)
        else:
            window.remove(nums[i-k])
            window.add(n)
        if len(window) == k:
            max_ = window[-1]
            ret.append(max_)
    return ret

assert(solve(nums = [1,3,-1,-3,5,3,6,7], k = 3) == [3, 3, 5, 5, 6, 7])
```

### Contains Duplicate III
 - 概要
   - indexの値の差が一定以下であり かつ valueの値が一定以下の要素の存在の判定
   - combinationを取ると、`O(n^2)`
   - B木でwindowを構築して、二分探索すると`O(k * k log k)`
 
```python
from sortedcontainers import SortedList

def solve(nums: List[int], index_diff: int, value_diff: int):
    # 長さが一定のwindowを作り、その中で二分探索をするイメージ
    window = SortedList()
    for i, value in enumerate(nums):
        if i > index_diff:
            window.remove(nums[i-(index_diff+1)])
        # 値の間の範囲をの太さのビームのイメージ
        i1 = window.bisect_left(value-value_diff)
        i2 = window.bisect_right(value+value_diff)
        if i1 != i2:
            return True
        window.add(value)
    return False
```

---

## 参考
 - [220. Contains Duplicate III/LeetCode](https://leetcode.com/problems/contains-duplicate-iii/description/)
 - [239. Sliding Window Maximum/LeetCode](https://leetcode.com/problems/sliding-window-maximum/description/)
