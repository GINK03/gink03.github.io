---
layout: post
title: "aws sagemaker"
date: 2024-04-21
excerpt: "aws sagemaker について"
tags: ["aws", "sagemaker"]
config: true
comments: false
sort_key: "2024-04-21"
update_dates: ["2024-04-21"]
---

# aws sagemaker について

## 概要
 - 機械学習モデルを構築、学習、デプロイするためのフルマネージドサービス
 - 簡易的な用途としては、Google Colab のようなマネージドノートブック環境としても利用可能
   - ノートブックとして使用する場合は、共用サーバとなるので、セキュリティには注意が必要
     - 個人の秘密鍵などを保存せず、一時tokenなどを利用することを推奨

## 利用方法

### ノートブックインスタンスの作成
 - `sagemaker` -> `ノートブック` を選択 > `ノートブックインスタンスの作成` > イメージを選択して`ノートブックインスタンスの作成`

### ノートブックインスタンスの起動
 - `ノートブックインスタンス` からインスタンスを選択 > `アクション` > `起動` 

### ノートブックインスタンスの停止
 - `ノートブックインスタンス` からインスタンスを選択 > `アクション` > `停止`
