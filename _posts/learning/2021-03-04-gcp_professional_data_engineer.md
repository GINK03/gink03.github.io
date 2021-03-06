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

## cloud data fusion: 4/5
 - GUIで扱えるデータパイプライン
   - cloud dataprocのラッパーのようになっている
 - ***web uiでの例***
 - `Data Fusion`からインスタンスを作成(10分程度かかる)
   - ***wrangler*** 
	 - gcsからcsvをインプットしたりしてその内容を特定のルールでパース
   - GUIから各プラグインをつなぎ、`input`, `join`, `output`を定義する
   - 各ソースにはbigqueryを用いることもできる

## cloud composer:
 - CRONのオンライン版
 - AirFlowで挙動を定義する
 - 起動に30分以上かかる
