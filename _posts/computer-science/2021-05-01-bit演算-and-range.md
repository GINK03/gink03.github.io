---
layout: post
title: "bit演算(range and)"
date: 2021-04-22
excerpt: "bit演算(range and)について"
computer_science: true
tag: ["bit operation", "bit演算", "range and"]
comments: false
sort_key: "2021-12-30"
update_dates: ["2021-12-30"]
---

# bit演算(range and)について

## 概要
 - 2つのbit表現の数値(left, right)があるとき、その間の数値をすべてandをとった際にどんな値になるか
 - bit表現を縦に見た時、一つでも0があれば0であり、leftとrightの一致する最大のbitが`[left, right]`間の値をすべてandをとったものとなる

<div>
  <img src="https://user-images.githubusercontent.com/4949982/180594849-c6a77784-1e51-46a3-a869-b31f943cf1e7.png">
</div>

## 具体的なコード

```python
def solve(left, right):
    shift = 0
    while 1:
        if left == right:
            break
        left = left >> 1
        right = right >> 1
        shift += 1
    return left << shift

assert solve(left = 5, right = 7) == 4
assert solve(left = 0, right = 0) == 0
assert solve(left = 1, right = 2147483647) == 0
```

## 参考
 - [201. Bitwise AND of Numbers Range/LeetCode](https://leetcode.com/problems/bitwise-and-of-numbers-range/)
