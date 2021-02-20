---
layout: post
title: "ベルマン方程式"
date: 2021-02-20
excerpt: "ベルマン方程式について"
computer_science: true
hide_from_post: true
tag: ["subprocess"]
comments: false
---

# ベルマン方程式について

## 概要
 - 複雑な時系列の相互作用を持つ価値の最大化
 - 一般的に動的計画法で解決される

## 価値`V`の定式化

$$
V = \max \sum_{t} \beta^t F(x_t, a_t) 
$$

 - `a`: 戦略
 - `x`: 状態
 - `β`: 割引率

## 再起を定義する

$$
V(x_0) = \max_{a} \{ F(x_0, a_0) + \beta V(x_1) \} 
$$

## 参考
 - [ベルマン方程式](https://ja.wikipedia.org/wiki/%E3%83%99%E3%83%AB%E3%83%9E%E3%83%B3%E6%96%B9%E7%A8%8B%E5%BC%8F)
