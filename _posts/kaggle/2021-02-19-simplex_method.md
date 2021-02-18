---
layout: post
title: "シンプレックス法"
date: 2021-02-19
excerpt: "シンプレックス法について"
kaggle: true
hide_from_post: true
tag: ["optimization", "simplex method", "シンプレックス法"]
comments: false
---

# シンプレックス法について

 - 線形計画の問題を解くアルゴリズムである
 - `最適解があるなら最適実行可能基底解が存在する`という前提がある

## 方法
 1. 全ての変数をプラスしか取らないような表現に変換
 2. 目的関数を最小化として解釈(陰関数)
 3. 制約条件の式にslack変数というダミー変数を入れる
 4. slack変数が対角行列になるので、slack変数でない変数の基底を求める作業を行う
   - 掃き出し法がメジャーである
 5. 掃き出し法の結果、`z=~`になった結果が最大値(最小値)である

## 参考
 - [シンプレックス法（単体法）](http://www.bunkyo.ac.jp/~nemoto/lecture/or/97/simplex/index.htm)
 - [シンプレックス法を雑に理解した](https://qiita.com/41semicolon/items/cd50a54c6e147e20c170)
