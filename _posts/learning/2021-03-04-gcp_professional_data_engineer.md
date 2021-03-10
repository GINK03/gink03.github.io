---
layout: post
title: "google cloud professional data engineer"
date: 2021-03-04
excerpt: "google cloud professional data engineer試験"
learning: true
tag: ["cloud"]
comments: false
---

# google cloud professional data engineer試験

## 出題範囲
 - [link](https://cloud.google.com/certification/guides/data-engineer)

## cloud data fusion
 - ***概要***
   - GUIで扱えるデータパイプライン
   - cloud dataprocのラッパーのようになっている
 - ***web uiでの例***
   - `Data Fusion`からインスタンスを作成(10分程度かかる)
   - ***wrangler*** 
     - gcsからcsvをインプットしたりしてその内容を特定のルールでパース
   - GUIから各プラグインをつなぎ、`input`, `join`, `output`を定義する
   - 各ソースにはbigqueryを用いることもできる
<img src="https://res.cloudinary.com/practicaldev/image/fetch/s--6xZH0ZBx--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/suo2glzw21i4fca5y5di.png">

## cloud composer
 - ***特徴***
   - AirFlowで挙動を定義する
   - 起動に30分以上かかる
 - ***cui***
   1. environmentsの作成
     - `gcloud composer environments create example-environment`
   2. AirFlowで定義したdagをstorageにupload
     - pythonスクリプト

