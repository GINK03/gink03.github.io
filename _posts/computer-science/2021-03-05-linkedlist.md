---
layout: post
title: "LinkedList"
date: 2021-03-04
excerpt: "LinkedListについて"
computer_science: true
hide_from_post: true
tag: ["algorithm", "data structure", "データ構造", "LinkedList"]
comments: false
sort_key: "2021-12-29"
update_dates: ["2021-12-29"]
---

# LinkedListについて

## 概要
 - arrayタイプのデータをハンドルする際のデータ構造の一つ 
 - ある要素から次への要素の参照を持つ

## 実装例

```python
class Node:
    def __init__(self, data):
        self.data = data
        self.next = None

class LinkedList:
    def __init__(self):
        self.head = None

    def print(self):
        tmp = self.head
        while tmp:
            print(tmp.data, end=", ")
            tmp = tmp.next
        print()

llist = LinkedList()
llist.head = Node(1)

second = Node(2)
third = Node(3)
llist.head.next = second
second.next = third

llist.print() # 1, 2, 3,
```

## 参考
 - [Linked List | Set 1@geeksforgeeks](https://www.geeksforgeeks.org/linked-list-set-1-introduction/)
