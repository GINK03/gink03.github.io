---
layout: post
title: "python heapq"
date: "2022-12-11"
excerpt: "python heapqの使い方"
config: true
tag: ["python", "heapq"]
comments: false
sort_key: "2022-12-11"
update_dates: ["2022-12-11"]
---

# python heapqの使い方

## 概要
 - listをラップしてheapとして利用する
 - orerderedのlistにしてくれるわけではない
   - orderedのlistがほしいときは独自に実装するか、SortedContainerを使用する

## 基本的な使用法

```python
import heapq

lst = [0, 2, 4, 5, 1]
heapq.heapify(lst)
heapq.heappush(lst, 3)

assert heapq.heappop(lst) == 0
```

## ordered listをheapで実装する

```python
class OrderedList:
    def __init__(self):
        self.small, self.large = [], []
    def append(self, num: int) -> None:
        if len(self.small) == len(self.large):
            heapq.heappush(self.large, -heapq.heappushpop(self.small, -num))
        else:
            heapq.heappush(self.small, -heapq.heappushpop(self.large, num))
    def getOrdered(self):
        return [-x for x in self.small] + self.large
    def findMedian(self) -> float:
            return (self.large[0] - self.small[0]) / 2 if len(self.small) == len(self.large) else self.large[0]

lst = OrderedList()
lst.append(3)
lst.append(2)
lst.append(1)
assert lst.getOrdered() == [1, 2, 3]
```

---

## 参考
 - [295. Find Median from Data Stream/LeetCode](https://leetcode.com/problems/find-median-from-data-stream/description/)

