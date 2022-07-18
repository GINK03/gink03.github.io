---
layout: post
title: "causual impact"
date: 2022-07-13
excerpt: "causual impact(因果推論)について"
kaggle: true
tag: ["機械学習", "因果推論", "causual impact"]
sort_key: "2022-07-13"
update_dates: ["2022-07-13"]
comments: false
---

# causual impact(因果推論)について

## 概要
 - `因果推論の根本問題`について
   - 推論対象(反実仮想)をどう求めるか
 - DIDのような簡単な関係ではなく、MLを用いて推論する
   - 目的変数に対してfitすれば良いので、kagglerが力を発揮する

## `因果推論の根本問題`について
 - 介入した効果の逆を求めるのは難しい
   - e.g.
     - 東京をロックダウンし感染症の数がわかっても、仮にロックダウンしなかった場合の数がわからないことが問題
       - 様々な地域のロックダウンしたなかった場合 or した場合の感染者数を当てるモデルを作成する
         - 説明変数として人口や産業業態やlatlonなどさまざまな特徴量を用いると仮定する
       - モデルで`東京のロックダウンしなかった場合`をシミュレーションする

### 凡例
<div align="center">
  <img src="https://user-images.githubusercontent.com/4949982/178656540-515638d7-ab9f-4415-b39c-61ce0c44d38c.png">
</div>

### ロックダウンの効果を求めたい場合
<div aling="center">
  <img src="https://user-images.githubusercontent.com/4949982/178656821-616d8727-16f0-4653-901a-6727062d0c63.png">
</div>

## 特徴量の選択について
 - 可能な限り、介入と相関がない特量を選ぶべきである
   - 介入に相関がある特徴量では、介入を変化させたときに、そちらも変更する必要があり、シミュレーションとして成立しない

## 参考
 - [効果検証入門〜正しい比較のための因果推論／計量経済学の基礎](https://www.amazon.co.jp/dp/B0834JN23Y/)
 - [因果推論におけるCausal Impactの立ち位置を俯瞰する/Qiita](https://qiita.com/neuman71/items/342f56f31ac35b7532e5)
