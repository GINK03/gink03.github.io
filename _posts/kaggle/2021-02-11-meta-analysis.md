---
layout: post
title: "meta analysisについて"
date: 2021-02-11
excerpt: "meta analysisについて"
kaggle: true
hide_from_post: true
tag: ["statistics", "meta-analysis"]
comments: false
sort_key: "2021-02-11"
update_dates: ["2021-02-11"]
---

# meta analysisについて

## 概要
サンプルが少ない研究を、複数の論文を束ねることで、有効な差の結果を導出するもの  

原則として各論文に重み付けして統合して結果を得る作業がメタアナリシスである  

## メタアナリシスが必要な理由
 - 少ないサンプルの研究が多い
   - サンプルが少ないと分散が大きい
     - 分散の逆数を重みとする: `固定効果モデル`
   - 研究ごとに偏りが存在するはずである
     - ランダム効果モデル

## メタアナリシスで気をつけるべき点
 - 出版バイアス：ファイルドロワーの問題
   - 製薬会社が都合が悪い結果を隠す傾向がある
     - これは本来あるべき分布から偏った分布になっている可能性がある
   - 心理学の25%が出版バイアスに苦慮している
     - `タンデム法`, `トリムアンドフィル法`等でバイアスを消す
 - 統計的に有意でない効果を報告していない研究に関連する問題
   - p値で有意にならなかった研究は捨てられている可能性がある

## 出版バイアスの意外な解決法
 - metacriticというレビューサイトでは各レビュワーの加重平均を行うための係数を与えているが、そのレビュワーの係数を公開していない  
 - metacriticはレビュワーの係数がブラックボックスにも関わらず、売上を示す指標として大変よくワークしている

[調査した論文](/metacritic/)

## 参考
 - [第6章 メタ分析](http://cogpsy.educ.kyoto-u.ac.jp/personal/Kusumi/datasem17/takano1.pdf)
 - [meta-analysis](https://en.wikipedia.org/wiki/Meta-analysis)
