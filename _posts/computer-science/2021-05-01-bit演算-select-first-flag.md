---
layout: post
title: "bit演算 select fist flag"
date: 2021-04-22
excerpt: "bit演算 select first flagについて"
computer_science: true
tag: ["bit operation", "bit演算"]
comments: false
sort_key: "2021-12-30"
update_dates: ["2021-12-30"]
---

# bit演算 select first flagについて

## 概要
 - `..xxx1010`のようなbit arrayがある時、`..xxx0010`を取り出すアルゴリズム
 - `Y & -Y`を計算するだけなので簡単
 
## 具体な挙動
 - `00000000000001010 = Y`があるとき、このbitの反転は`~Y`である
 - `11111111111110101 = ~Y`
 - `-Y = ~Y + 1`であるから`11111111111110110 = ~Y + 1 = -Y`
 - `00000000000000010 = Y & -Y`

## 参考
 - [Elegant, fast and easy-understand Python solution/LeetCode](https://leetcode.com/problems/gray-code/discuss/245076/4-lines-Elegant-fast-and-easy-understand-Python-solution)
