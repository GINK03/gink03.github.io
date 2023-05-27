---
layout: post
title: "PPO(Proximal Policy Optimization)" 
date: 2023-05-27
excerpt: "PPO(Proximal Policy Optimization)について"
kaggle: true
tag: ["強化学習", "KLダイバージェンス", "open ai"]
comments: false
sort_key: "2023-05-27"
update_dates: ["2023-05-27"]
---

# PPO(Proximal Policy Optimization)について

## 概要
 - openaiが開発した強化学習手法の一つ
 - 一つのメトリックスに対して学習を続けると、モデルが不安定になったり出力に多様性が失われたりすることから取り入れられた方法
 - 実験ではワークしている

## 具体的な仕組み
 - 強化学習のエージェントにて学習させるモデルをA, 学習させていないモデルをBとすると、`KL(A|B)`が一定以内に収まるように学習させるアプローチ
   - 単純に強化学習の損失に距離が遠いほどネガティブに作用するでも良い

## 参考
 - [Proximal Policy Optimization (PPO) Explained](https://towardsdatascience.com/proximal-policy-optimization-ppo-explained-abed1952457b)
 - [話題爆発中のAI「ChatGPT」の仕組みにせまる](https://qiita.com/omiita/items/c355bc4c26eca2817324)
