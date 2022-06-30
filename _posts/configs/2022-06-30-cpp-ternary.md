---
layout: post
title: "cppのternary(三項演算子)"
date: 2022-06-30
excerpt: "cppのternary(三項演算子)の使い方"
tags: ["c++", "cpp", "ternary", "三項演算子"]
config: true
comments: false
sort_key: "2022-06-30"
update_dates: ["2022-06-30"]
---

# cppのternary(三項演算子)の使い方

## 概要
 - 見ずらいC++の三項演算子の書き方について
   - 一般的に多用しないほうがいいと言われている
 - 英語では、ternary operatorという

## 凡例

```cpp
auto val = (condition) ? (真の時) : (偽の時)
```

## C++における別の書き方

```cpp
const int x = [&] -> int { if (a < b) return b; else return a; }
```
 - lambdaを用いて記述すると多少マシ

## 参考
 - [Conditional or Ternary Operator (?:) in C/C++](https://www.geeksforgeeks.org/conditional-or-ternary-operator-in-c-c/)
 - [三項演算子?:は悪である。](https://qiita.com/raccy/items/0b25b2f106e2a813828b)
