---
layout: post
title: "cloud dataflow"
date: 2021-03-13
excerpt: "cloud dataflowについて"
tags: ["cloud dataflow", "apache beam", "gcp"]
config: true
comments: false
sort_key: "2021-06-19"
update_dates: ["2021-06-19"]
---

# cloud dataflowについて

## 概要
 - apache beam alternative
 - 賢いmap reduce
 - オンライン処理ができる

## ストリーミングでモニタリングする
 - ***サンプルコード***
   - [sandiego](https://github.com/GoogleCloudPlatform/training-data-analyst/tree/master/courses/streaming/process/sandiego)
   - **sliding windowを使ったパイプラインの例**
	 - [AverageSpeeds.java](https://github.com/GoogleCloudPlatform/training-data-analyst/blob/master/courses/streaming/process/sandiego/src/main/java/com/google/cloud/training/dataanalyst/sandiego/AverageSpeeds.java)
 - **monitoring**
   - 出力をbigqueryをつなげて、`monitoring` -> `メトリック作成` -> 必要ならな`monitoring/alert`でアラートを作成する

## パイプラインのWeb UIでの確認

<div>
  <img style="align: center !important; width: 300px !important;" src="https://user-images.githubusercontent.com/4949982/111030349-0b2c6200-8445-11eb-8848-e9da87751827.png">
</div>


