---
layout: post
title: "gcp cloud memorystore"
date: "2022-08-11"
excerpt: "gcp cloud memorystoreの使い方"
config: true
tag: ["gcp", "gcloud", "redis", "memcached"]
comments: false
sort_key: "2022-08-11"
update_dates: ["2022-08-11"]
---

# gcp cloud memorystoreの使い方

## 概要
 - マネージドの`redis`または`memcached`
 - デフォルトでアクセスが同じ管理グループに限定されるのでセキュリティ的に安心
   - localからアクセスするには同じzoneにcomputeインスタンスを用意する必要がある

## redisの具体例

### redisインスタンスの作成

```console
$ gcloud redis instances create <instance-name> --size=1 --region=asia-northeast2
```
 - `size`
   - メモリサイズ
 - `region`
   - 必須

### 作成されたインスタンスの確認

```console
$ gcloud redis instances list --region=asia-northeast2
```
 - IPアドレスやホスト名を確認できる


### アクセス例

```console
$ sudo apt install telnet
$ telnet <redis-ipaddress> 6379
PING
+PONG
```
 - 同じzoneのcomputeインスタンスからアクセスする必要がある


## 参考
 - [入門ガイド/memorystore](https://cloud.google.com/memorystore/docs/redis/how-to)
 - [Accessing GCP Memorystore from local machines/stackoverflow](https://stackoverflow.com/questions/50281492/accessing-gcp-memorystore-from-local-machines)
