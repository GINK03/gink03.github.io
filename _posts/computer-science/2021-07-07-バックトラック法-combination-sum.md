---
layout: post
title: "バックトラック法-combination-sum"
date: 2021-07-07
excerpt: "バックトラック法-combination-sum"
computer_science: true
hide_from_post: true
tag: ["algorithm", "dfs", "バックトラック法"]
comments: false
sort_key: "2021-08-21"
update_dates: ["2021-08-21"]
---

# バックトラック法 combination-sumについて

## 概要
 - dfsを利用したバックトラック法
 - bit全探索では繰り返しの要素選択に対応できないので、dfsを用いたバックトラック法が適応例

## 設定
 - `candidates = [2,3,6,7]`, `target = 7`の時、`[[2,2,3],[7]]`
 - `candidates = [2,3,5]`, `target = 8`の時、`[[2,2,2,2],[2,3,3],[3,5]]`

## ソリューション

```python
from typing import List

class Solution:
    def combinationSum(self, candidates: List[int], target: int) -> List[List[int]]:
        A = []
        dfs(candidates, target, buff=[], sum_buff=0, A=A)
        return A

def dfs(candidates, target, buff, sum_buff: int, A):
    for candidate in candidates:
        if buff != [] and buff[-1] > candidate:
            continue
        new_sum_buff = sum_buff + candidate
        if new_sum_buff < target:
            dfs(candidates, target, buff + [candidate], new_sum_buff, A)
        if new_sum_buff == target:
            A.append(buff + [candidate])
```

## 参考
 - [Combination Sum/LeetCode](https://leetcode.com/problems/combination-sum/)
