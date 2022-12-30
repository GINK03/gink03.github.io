---
layout: post
title: "inorderとpreorderとpostorder"
date: 2022-11-30
excerpt: "inorderとpreorderとpostorderについて"
computer_science: true
tag: ["algorithm", "data structure", "データ構造", "bst", "binary search tree", "二分木", "二分探索木"]
comments: false
sort_key: "2022-11-30"
update_dates: ["2022-11-30"]
---

# inorderとpreorderとpostorderについて

## 概要
 - dfsの記録順序によって`inorder`と`preorder`と`postorder`がある
 - `preorder`は事前にスキャン
   - `Node -> Left -> Right`
 - (二分木の場合)`inorder`はLeftをスキャンしてからRightをスキャンする順
   - `Left -> Node -> Right`
 - `postoder`は戻りがけのスキャン
   - オイラー路(一筆書きの経路)を記録するときなど
 - 二分探索木は一般的なデータの入れ方であれば、左に小さい値が入っているので、`inorder`でデータを取得すれば昇順で結果を得られる

## 二分木の具体的な実装
 
**ノード**
```python
class TreeNode:
    def __init__(self, val: int, left: Optional["TreeNode"], right: Optional["TreeNode"]):
        self.val = val
        self.left = left
        self.right = righ
```

**preorder**
```python
def preorder_dfs(node, lst):
    lst.append(node.val)
    if node.left:
        preorder_dfs(node.left, lst)
    if node.right:
        preorder_dfs(node.right, lst)
```

**inorder**
```python
def inorder_dfs(node, lst):
    if node.left:
        inorder_dfs(node.left, lst)
    lst.append(node.val)
    if node.right:
        inorder_dfs(node.right, lst)
```

---

## 参考
 - [230. Kth Smallest Element in a BST/LeetCode](https://leetcode.com/problems/kth-smallest-element-in-a-bst/)
