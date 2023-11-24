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
 - 通常のログとは異なり、structured loggingを用いる事ができる
   - jsonでのログ出力が可能

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

## pythonでのログの出力

### ライブラリのインストール
```console
$ pip install google-cloud-logging
```

### structured logの出力
```python
import google.cloud.logging
import logging
import json

client = google.cloud.logging.Client()
client.setup_logging()

# 方法1. extraで渡す
data_dict = {"hello": "world"}
logging.warning("message field", extra={"json_fields": data_dict})

# 方法2. json.dumpsで渡す
data_dict = {"hello": "world"}
logging.info(json.dumps(data_dict))
```

## 用語

### sink
 - `cloud storage`や`bigquery`が最終アウトプット先ならばsinkは一歩手前のバッファ
 - [docs/export](https://cloud.google.com/logging/docs/export)

## 参考
 - [Google Cloud Logging Python v3.0.0 スタートガイド](https://cloud.google.com/blog/ja/products/devops-sre/google-cloud-logging-python-client-library-v3-0-0-release?hl=ja)

