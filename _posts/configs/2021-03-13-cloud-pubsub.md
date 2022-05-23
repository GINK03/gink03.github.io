---
layout: post
title: "cloud pub/sub"
date: 2021-03-13
excerpt: "cloud pub/subについて"
tags: ["cloud pub/sub", "gcp"]
config: true
comments: false
sort_key: "2021-06-19"
update_dates: ["2021-06-19"]
---

# cloud pub/subについて

## 概要
グローバルメッセージングサービス

## topicの作成

```console
$ gcloud pubsub topics create ${TOPIC}
```

## メッセージの送信

```console
$ gcloud pubsub topics publish ${TOPIC} --message "hello"
```

## サブスクリプションの作成

```console
$ gcloud pubsub subscriptions create --topic ${TOPIC} ${SUBSCRIPT}
```

## メッセージのpull

```console
$ gcloud pubsub subscriptions pull --auto-ack ${SUBSCRIPT}
```


