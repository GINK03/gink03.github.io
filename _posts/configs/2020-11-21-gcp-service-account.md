---
layout: post
title: "gcp service account"
date: 2020-11-21
excerpt: "gcp service accountについて"
project: false
config: true
tag: ["GOOGLE_APPLICATION_CREDENTIALS", "gcp", "service account"]
comments: false
sort_key: "2021-09-08"
update_dates: ["2021-09-08"]
---

# gcp service accountについて

## 概要
 - `GCPのサービスアカウント`とはGCPのサービスにアクセスする権限をもったユーザのような概念  
   - サービスアカウントごとにパーミッションを設定できる

## 環境変数に追加して利用する場合
 - `サービスアカウントのキー`は、`Service Accounts`のページの`操作`の`鍵を作成`から生成が可能である  
 - `export GOOGLE_APPLICATION_CREDENTIALS="<path-to-credential-file>.json"`  
 - サービスアカウントのクレデンシャルを作成することになるので、この方法にはセキュリティ上の懸念がある

## ユーザに紐づくサービスアカウントのクレデンシャルを発行する
 - `$ gcloud auth application-default login`
   - 期限付きの`~/.config/gcloud/applicstion_default_credentials.json`が得られる
 - このファイルがある場合、自動的に使用される

## メタデータを利用する場合
 - GCPのcompute instances/cloud functionsなどにはサービスアカウントの割当が可能であり、何もしなくてもメタデータによる認証が自動的に行われる

## Gapps, APIのサービスアカウントの権限
 - Gapps, APIへのアクセス権限は明示的に与えなくても、なんの権限も付与していないサービスアカウントでアクセスできる  

