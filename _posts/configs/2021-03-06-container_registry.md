---
layout: post
title: "gcr, container registry"
date: 2021-03-06
excerpt: "gcr, container registryについて"
tags: ["gcp", "gcr", "container registry"]
config: true
comments: false
---

# gcr, container registryについて

## 概要
 - gcp版dockerhub  
 - あまりパブリックに運用することを想定していない

## dockerコマンドの認証を通す

`gcloud`コマンドの認証を通した状態で
```console
$ gcloud auth configure-docker
```

## docker imageの命名規則

 - `gcr.io/${PROJECT_NAME}/${CONTAINER_NAME}:$TAG`

## 料金
 - 各価格
   - 1GBあたり$0.026
   - ネットワークの下りのみ課金される
 - 参考
   - [link](https://cloud.google.com/container-registry/pricing?hl=ja)
