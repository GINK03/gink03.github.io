---
layout: post
title: "embedrank"
date: 2023-10-02
excerpt: "embedrankの概要"
tag: ["nlp", "embedrank", "python"]
comments: false
sort_key: "2023-10-02"
update_dates: ["2023-10-02"]
---

# embedrankの概要

## 概要
 - 単語のフレーズを埋め込みベクトルを用いて表現し、その類似度を用いて文書の重要度を計算する手法
 - 文章を代表するフレーズを得られる

## 使用できる埋め込みベクトル
 - Word2Vec
 - FastText
 - BERT

## フレーズの多様性を確保するための手法
 - [/MMR/](/MMR/)

## 参考
 - [github.com/yagays/embedrank](https://github.com/yagays/embedrank)
   - gensimのバージョンが古いため、docker containerでしか動かない

