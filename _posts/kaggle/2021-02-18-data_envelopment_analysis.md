---
layout: post
title: "包絡分析法(DEA)"
date: 2021-02-18
excerpt: "包絡分析法(DEA, data envelopment analysis)"
kaggle: true
hide_from_post: true
tag: ["optimization"]
comments: false
sort_key: "2021-02-18"
update_dates: ["2021-02-18","2021-02-18"]
---

# 包絡分析法(DEA, data envelopment analysis)について

## 概要
事業kが存在するとき入力を`x`, 出力を`y`それぞれの係数を`v`, `u`とすると以下のような最適化に変換できる  

$$
maximize \sum_{i=0} u_{i}y_{i} / \sum_{i=0} v_{i}x_{i}  \\
s.t. \sum_{i=0} u_{i}y_{i} / \sum_{i=0} v_{i}x_{i} \leq 1 \\
v \geq 0 \\
u \geq 0
$$

これだと線形計画問題にできないので変形して以下のように単純化する

$$
maximize \sum_{i=0} u_{i}y_{i}  \\
s.t. \sum_{i=0} u_{i}y_{i}  \leq \sum_{i=0} v_{i}x_{i}  \\
v \geq 0 \\
u \geq 0
$$

(効率が1が最大と仮定しているのに多少違和感があるが赤字にならなければいいみたいな発想か？)
