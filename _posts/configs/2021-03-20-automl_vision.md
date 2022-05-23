---
layout: post
title: "gcp automl-vision"
date: 2021-03-20
excerpt: "automl visonついて"
tags: ["gcp", "automl", "image"]
config: true
comments: false
sort_key: "2021-03-20"
update_dates: ["2021-03-20"]
---

# automel-visionについて 
 - gcpの機能の一つ
 - 画像

## ドキュメント
 - [docs](https://cloud.google.com/vision/automl/docs)

## 一般的なユースケース
 - gcsに画像と画像のパスを記したcsvをアップロード
 - `AutoML Vison`を開いて新しいデータセットから選択する
 - モデルのタイプを決定する(Cloud host or edge)
 - ノード時間予算を決定する

## edgeで使用できるようにモデルを出力する
 - `[テストと使用]` -> `[モデルを使用する]` -> `[TF Lite]`
 - `model.tflite`, `dict.txt`, `tflite_metadata.json`からなる
