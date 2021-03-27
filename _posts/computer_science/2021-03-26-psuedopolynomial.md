---
layout: post
title: "Psuedopolynomial"
date: 2021-03-26
excerpt: "Psuedopolynomial(疑多項式)について"
computer_science: true
hide_from_post: true
tag: ["algorithm", "psuedopolynomial"]
comments: false
---

# Psuedopolynomial(疑多項式)について
多項式時間でとける問題(selection sortなど)は、入力の多項式時間`O(n^k)`で示される  
例えば入力がbitで示されるとき、1bit増えると計算量は２倍である。このとき`O(2^kn)`のような形で示され、入力が増えるごとに爆発的に計算量が増える(そしてこれは多項式時間でない)  
多項式時間では表現が適切でなく、`入力に含まれる数量の多項式`で表せるときに疑多項式と呼ぶ  
暗号理論の複素数が含まれるのは擬多項式だからである  

## 参考
 - [拙訳: 擬多項式時間アルゴリズムとは何か](https://blog.hellorusk.net/posts/20200113)
 - [NとかNPとか困難とか完全とか（２）](http://techtipshoge.blogspot.com/2011/06/nnp_12.html)
