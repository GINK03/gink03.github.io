---
layout: post
title: "numpy random seed"
date: 2024-06-24
excerpt: "numpy random seedの使い方"
project: false
kaggle: true
tag: ["numpy", "python"]
comments: false
sort_key: "2024-06-24"
update_dates: ["2024-06-24"]
---

# numpy random seedの使い方

## 概要
 - `np.random.seed(42)`で乱数のシードを固定することができる
 - pandasのsample関数なども結果が固定される
 - jupyter ではセルの実行順序を変えると結果が変わるので注意
