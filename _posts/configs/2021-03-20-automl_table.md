---
layout: post
title: "gcp automl-table"
date: 2021-03-20
excerpt: "automl tableついて"
tags: ["gcp", "automl", "tablur"]
config: true
comments: false
---

# automel-tablesについて 
 - **概要**
   - gcpの機能の一つ
   - テーブルデータ特化
 - **ドキュメント**
   - [docs](https://cloud.google.com/automl-tables)
 - **code**
   - python
   - nodejs
 - **制約**
   - 100GB以下
   - ラベルが含まれている必要がある
   - 列は1000程度まで
 - **インプット**
   - csv
   - gs
   - bigquery
 - **評価**
   - AUC PR
   - AUC ROC
   - F1
   - 適合率
   - 再現率
   - 混合行列
   - 特徴量重要度
 - **予測**
   - オンライン
   - バッチ
 - **モデルのエクスポート**
   - gcsにエクスポートしてdocker経由で使える
