---
layout: post
title: "binary search treeについて"
date: 2021-03-28
excerpt: "binary search tree(二分木)について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "data structure", "データ構造", "bst", "binary search tree", "二分木"]
comments: false
---

# binary search tree(二分木)について
 - binary search(二分探索)に名前が似ているが別のものである
   - 特性自体は似ており、検索コストが`O(log n)`である

## ランダウ表記
 - 平均と最悪ケースが存在する

| algorithm |  average | worst case |
|-----------|:--------:|:----------:|
| space     |   O(n)   |    O(n)    |
| find      | O(log n) |    O(n)    |
| insert    | O(log n) |    O(n)    |
| delete    | O(log n) |    O(n)    |


## pythonによる実装
 - 実装が長いため参考リンクを貼る
   - [github](https://github.com/OmkarPathak/Data-Structures-using-Python/blob/master/Trees/BinarySearchTree.py)
