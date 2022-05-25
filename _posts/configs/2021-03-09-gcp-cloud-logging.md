---
layout: post
title: "gcp cloud logging"
date: 2021-03-09
excerpt: "gcp cloud loggingについて"
tags: ["gcp", "python"]
config: true
comments: false
sort_key: "2021-06-19"
update_dates: ["2022-05-25", "2021-06-19"]
---

# cloud loggingについて

## 概要
 - gcpのloggingの仕組みの一つ
 - `cloud monitoring`というサービスと連携させて用いる
 - オンプレの連携も可能

## 公式ドキュメント
 - [cloud.google.com/logging/docs](https://cloud.google.com/logging/docs)

## gcloudを利用してログを書き込む
**非構造化データを書き込む**
```console
$ gcloud logging write my-test-log "A simple entry."
```
 - `my-test-log`の作成は必要ない

**構造化データを書き込む**
```console
$ gcloud logging write --payload-type=json my-test-log '{ "message": "My second entry", "weather": "partly cloudy"}'
```

## compute engineに対してロギングソフトをインストールする
 - vmインスタンスに`cloud monitoring`と`cloud logging`のソフトウェアを入れてservice startする
 - `cloud monitoring`でメトリックス等を作成して反映する

## monitoring query language
 - `cloud monitoring`の画面で`mql`に変更する
 - jq的なコマンドでクエリを作成するとログをフィルタし、その結果を知ることができる

## 用語

### sink
 - `cloud storage`や`bigquery`が最終アウトプット先ならばsinkは一歩手前のバッファ
 - [docs/export](https://cloud.google.com/logging/docs/export)


