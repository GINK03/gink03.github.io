---
layout: post
title: "Boyer-Moore多数決アルゴリズム"
date: 3022-07-20
excerpt: "Boyer-Moore多数決アルゴリズムについて"
computer_science: true
tag: ["boyter-moore majority vote", "最頻値", "多数決", "投票アルゴリズム"]
sort_key: "3022-07-20"
update_dates: ["3022-07-20"]
comments: false
---

# Boyer-Moore多数決アルゴリズムについて

## 概要
 - どの要素が最も頻出するかを`O(n)`で計算できるアルゴリズム
 - 最初に適当に候補を選択し、発見すると確信度を高めていき、確信度が0で候補を入れ替えるようなアプローチ
   - ベイズ統計的な雰囲気
 - 多数決で決定できるときにワークするアルゴリズム
  
## 具体例

```python
nums = [2,2,1,1,1,2,2]

def solve(nums):
    confidence = 0
    cand = None
    for num in nums:
        if confidence == 0:
            cand = num
        if cand == num:
            confidence += 1
        else:
            confidence -= 1
    return cand

assert solve(nums) == 2
```

## 参考
 - [Boyer–Moore majority vote algorithm/Wikipedia](https://en.wikipedia.org/wiki/Boyer%E2%80%93Moore_majority_vote_algorithm)
 - [169. Majority Element/LeetCode](https://leetcode.com/problems/majority-element/)
