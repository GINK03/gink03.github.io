---
layout: post
title: "LinkedList(連結リスト)"
date: 2021-03-04
excerpt: "LinkedList(連結リスト)について"
computer_science: true
tag: ["algorithm", "data structure", "データ構造", "LinkedList"]
comments: false
sort_key: "2021-12-29"
update_dates: ["2021-12-29"]
---

# LinkedList(連結リスト)について

## 概要
 - arrayタイプのデータをハンドルする際のデータ構造の一つ 
 - ある要素から次への要素の参照を持つ
 - dfs, bfsで探索できる

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

## fast, slowポインターでちょうど半分までたどる

```python
# in 1->2->3->4->5->6 find 4 
slow = fast = head
while fast and fast.next:
    slow = slow.next
    fast = fast.next.next
```

## LinkedListを逆順にする

```python
prev, curr = None, head
while curr:
    tmp = curr.next
    curr.next = prev
    prev = curr
    curr = tmp
```
 - tmpの変数を用いることで逆順にすることができる

## 参考
 - [Linked List | Set 1@geeksforgeeks](https://www.geeksforgeeks.org/linked-list-set-1-introduction/)
 - [143. Reorder List/LeetCode](https://leetcode.com/problems/reorder-list/)
