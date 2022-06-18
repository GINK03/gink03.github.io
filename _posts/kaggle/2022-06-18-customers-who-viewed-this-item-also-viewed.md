---
layout: post
title: "customers who viewed this item also viewed"
date: 2022-06-18
excerpt: "customers who viewed this item also viewedについて"
kaggle: true
tag: ["機械学習", "レコメンド", "customers who viewed this item also viewed"]
sort_key: "2022-06-18"
update_dates: ["2022-06-18"]
comments: false
---

# customers who viewed this item also viewed(この商品を見ている人はこの商品も見ています)について

## 概要
 - レコメンドアルゴリズムの一つ
 - 強力
 - 様々な実装法
 - 特定の人気のユーザに偏ることがある

## 計算方法1
 - 具体的な計算方法
   - MFと同様に`user x item`の行列を作成する
   - item軸をクエリベクトルとして全体の行列から類似度を計算する
 - メリットとデメリット
   - メリット
     - コサイン類似度で一括して計算できる
   - デメリット
     - すべてを計算するので計算が重い

## 計算方法2
 - 具体的な計算方法
   - \\(item_a = [user_{x}, user_{y}, ..., user_{z}]\\)をすべてのアイテムについて計算する
   - \\(user_A = [item_a, item_b, ..., item_z]\\)をすべてのユーザについて検索する
   - itemに紐づくユーザに紐づくアイテムを集計し、頻度の降順がレコメンドとなる
 - メリットとデメリット
   - メリット
     - 一件だけの結果を計算するで早い
     - 特定のユーザの出現確率を調整可能
   - デメリット
     - オンメモリでデータを所有するとメモリを消費する


## 調整とヒューリスティック
 - 出現確率の調整
   - itemをいくつかランダムサンプルし、そのアイテムのレコメンド結果をofflineで計算する
   - 特定のitemの偏り具合を計算し、偏り具合を解消する重みを与える

## 参考
 - [Customers Who Viewed This Item Also Viewed …](https://towardsdatascience.com/customers-who-viewed-this-item-also-viewed-40026c4eb700)
