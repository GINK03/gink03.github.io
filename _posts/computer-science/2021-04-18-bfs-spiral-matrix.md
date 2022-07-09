---
layout: post
title: "bfsでspiral matrix"
date: 2021-04-18
excerpt: "bfsでspiral matrixを行う"
computer_science: true
tag: ["algorithm", "bfs", "breadth-first search", "dp"]
comments: false
sort_key: "2022-01-19"
update_dates: ["2022-01-19","2021-12-30"]
---

# bfsでspiral matrixを行う

## 概要
 - bfsに有限オートマトンを組み合わせることで、matrixを渦状の順番でアクセスすることができる
 - bfsで次のグラフに移動する際に、優先順位が前の状態に依存することを利用する

## 具体例

```python
import collections

def solve(m):
    dp = [[True]*len(m[0]) for _ in range(len(m))]
    dp[0][0] = False

    lst = [m[0][0]]
    que = collections.deque([(0, 0)])

    state = 0
    while len(m[0])*len(m) > len(lst):
        h, w = que.popleft()
        dic = {0: (h, w+1),
               1: (h+1, w),
               2: (h, w-1),
               3: (h-1, w)}
        nh, nw = dic[state%4]
        # はみ出したりぶつかったら、stateを更新して、やり直し
        if nh < 0 or nw < 0 or nh >= len(m) or nw >= len(m[0]) or dp[nh][nw] == False:
            state += 1
            que.append((h,w))
            continue
        que.append((nh, nw))
        lst.append(m[nh][nw])
        dp[nh][nw] = False
    return lst

assert solve(m=[[1,2,3],[4,5,6],[7,8,9]]) == [1,2,3,6,9,8,7,4,5]
assert solve(m=[[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]]) == [1,2,3,4,8,12,16,15,14,13,9,5,6,7,11,10]
```

## 参考
 - [54. Spiral Matrix/LeetCode](https://leetcode.com/problems/spiral-matrix/)
