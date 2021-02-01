---
layout: post
title: "ieee-fraud-detection"
date: 2021-01-31
excerpt: "ieee-fraud-detectionのsolution"
kaggle: true
hide_from_post: true
tag: ["ieee-fraud-detection", "kaggle", "solution", "python"]
comments: false
---

# ieee-fraud-detectionのsolution

## 概要
 - テーブルデータ
 - クレジットカードの不正利用を検出する

### 1位のソリューション
 - link
   - https://www.kaggle.com/c/ieee-fraud-detection/discussion/111284
 - who
   - Chris Deotte

#### 魔法の特徴
 - `transaction`を予測する問題であったが、`client`を予測した
   - これはラベルの付け方の定義に基づけばそのほうが良かったということ

#### オーバーフィット防止
 - `client`の特徴を作る際に、`clientを唯一に表すUIDを使わない`
 - `train`, `test`のデータの双方にあるデータを用いて適切に設計する
   - uidを見つけるスクリプトを作成する必要があり、これによってスコアが大幅に伸びた

#### 特徴量選択
 - 前方特徴量選択
 - 再帰的な特徴量選択
 - 順序の重要性
 - 敵対的検証
 - 相関分析
 - 時間の一貫性
   - 最初の月のデータから最後の月の状態を予測して、ネガティブに働く特徴量を除去したりした
   - このコンペのユニークなポイント
 - クライアントの一貫性
 - train/test分布分析


### 2位のソリューション
 - link
   - https://www.kaggle.com/c/ieee-fraud-detection/discussion/111321
 - who 
   - cpmp

#### 特徴量エンジニアリング
 - `UID`を示すような値を様々に仮説し、いろいろなパターンを作ったらしい
