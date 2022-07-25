---
layout: post
title: "perplexity"
date: 2022-07-25
excerpt: "perplexityについて"
kaggle: true
tag: ["機械学習", "perplexity"]
sort_key: "2022-07-25"
update_dates: ["2022-07-25"]
comments: false
---

# perplexityについて

## 概要
 - NLPなどで使われるその文章がどの程度の妥当性があるかを判定する指標
 - perplexityはエントロピーを用いて計算される
   - 確率分布に偏りが大きければ小さい値になる

## 定義

$$
PP(x) :=  2^{H(p)} = 2^{-\sum p(x) \log_2p(x)} = \prod p(x)^{-p(x)}
$$

## 参考
 - [Perplexity/Wikipedia](https://en.wikipedia.org/wiki/Perplexity)
