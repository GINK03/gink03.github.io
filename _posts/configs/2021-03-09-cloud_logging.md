---
layout: post
title: "cloud logging"
date: 2021-03-09
excerpt: "cloud loggingについて"
tags: ["gcp", "python"]
config: true
comments: false
---

# cloud loggingについて

## command経由で実行

## 公式ドキュメント
 - [docs](https://cloud.google.com/logging/docs)

**非構造化データを書き込む**
```console
$ gcloud logging write my-test-log "A simple entry."
```
 - `my-test-log`の作成は必要ない

**構造化データを書き込む**
```console
$ gcloud logging write --payload-type=json my-test-log '{ "message": "My second entry", "weather": "partly cloudy"}'
```

## sinkとは
 - `cloud storage`や`bigquery`が最終アウトプット先ならばsinkは一歩手前のバッファ
 - [docs/export](https://cloud.google.com/logging/docs/export)


