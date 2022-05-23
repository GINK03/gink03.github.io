---
layout: post
title: "deel reinforcement learning"
date: 2021-02-20
excerpt: "deep reinforcement learningの論文"
kaggle: true
hide_from_post: true
tag: ["rf"]
comments: false
sort_key: "2021-02-20"
update_dates: ["2021-02-20","2021-02-20"]
---

# deep reinforcement learningの論文
 - deel Q learningの初めてに近い論文を読んだのでまとめる

## 前提と式  

**状態**  

$$
A = \{1, ..., k\}
$$

**報酬**  

$$
r_t
$$  

累積した報酬  

$$
R_t = sum_{t'=t}{T} \gamma^{t'-t} r_t' 
$$

**割引率**  

$$
\gamma
$$

**ポリシーマッピング**  
あるシーンにおける取れるアクションの制約を示す  

$$
\pi
$$

**Q関数**  

$$
Q^*(s, a) = \max_\pi E[R_t|s_t=s, a_t=a, \pi]
$$

ベルマン方程式から以下のように変形できる  

$$
Q^*(s, a) = \max_\pi E[r+\gamma \max Q(s', a')|s, a]
$$

## 結果
 - 人間を超える性能
 - 特徴量を単純化した等はあるが、ネットワークの記述が薄い(2013年の論文なので)

## 参考
 - [Playing Atari with Deep Reinforcement Learning](https://arxiv.org/pdf/1312.5602.pdf)
