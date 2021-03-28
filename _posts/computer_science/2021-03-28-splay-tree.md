---
layout: post
title: "splay treeについて"
date: 2021-03-28
excerpt: "splay treeについて"
computer_science: true
hide_from_post: true
tag: ["algorithm", "data structure", "データ構造", "splay tree"]
comments: false
---

# splay treeについて
 - binary search tree(二分探索木)の改良版
 - 木の回転をアクセスあるたびに行い、アクセスした要素がrootノードになるようにして最適化を行う
 - **挙動**
   - *zig*
	 - 特定の要素のノードを中心として回転する
   - *zig-zig*
	 - 特定の要素のノードの隣(右か左)を中心として回転する
   - *zig-zag*
	 - 特定の要素のノードを中心として繋ぎ変えてflattenする
