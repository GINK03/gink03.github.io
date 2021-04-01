---
layout: post
title: "確率過程"
date: 2021-04-01
excerpt: "確率過程(stochastic process)について"
kaggle: true
hide_from_post: true
tag: ["stochastic process", "statistics"]
comments: false
---

# 確率過程(stochastic process)について

## 独立定常増分過程
 - 各時系列でそれぞれが独立であること

## ブラウン運動
 - ブラウン運動(B)の定義
   - Bは独立定常増分過程
   - `μ = 0`, `σ^2 = 1`である

## ポアソン過程
 - `λt`を強度とする

$$
P(N_t = k) = e^{-\lambda t}\frac{(\lambda t)^k}{k!}
$$

## 複合ポアソン過程
 - **概要**
   - k回目のイベントまでに何らかの量Uが起こる累積和
 - **具体例**
   - 時刻tまでの発生回数をNとする
   - k回目の地震が起こるまでの損害額Uとしたきの累積和X

$$
E[N_t]=\lambda t \\
E[U_k]=\mu\\
V[U_k]=\sigma^2
$$

ならば

$$
E[X_t] = \mu E[N_t] = \lambda \mu t \\
V[X_t] = \lambda t (\mu^2 + \sigma ^2)
$$
