---
layout: post
title: "アレイデータ(two pointers)"
date: 2021-03-04
excerpt: "アレイデータ(two pointers)について"
computer_science: true
tag: ["algorithm", "data structure", "データ構造", "array"]
comments: false
sort_key: "2022-01-19"
update_dates: ["2022-01-19","2021-12-29"]
---

# アレイデータ(two pinters)について

## 概要
 - ２回以上の要素の探索が必要な時、２回ループを回すと、`O(n^2)`になってしまう
 - ２つのポインタ(カーソル)を利用して、`O(n)`に計算量を落とす工夫の総称をtwo pointersという

## 具体例

### ソート済みのアレイで２つの要素の足し算が特定の値になるか判定
 - 左端、右端から探索を初めて条件に応じて1stepずつ適切な方向にずらすイメージ

```python
def solve(numbers, target):
    nums = numbers
    l, r = 0, len(nums)-1
    while 1:
        tmp = nums[l] + nums[r]
        if tmp == target:
            return True
        elif tmp > target:
            r -= 1
        elif tmp < target:
            l += 1
    return False

assert solve(numbers = [2,7,11,15], target = 9)
```

## 参考
 - [167. Two Sum II - Input Array Is Sorted/LeetCode](https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/)
