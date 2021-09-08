---
layout: post
title: "gcp service account"
date: 2020-11-21
excerpt: "gcp service accountについて"
project: false
config: true
tag: ["GOOGLE_APPLICATION_CREDENTIALS", "gcp"]
comments: false
---

# gcp service accountについて

## 概要の理解
 - `GCPのサービスアカウント`とはGCPのサービスに悪世する権限をもったユーザのような概念  
   - サービスアカウントごとにパーミッションを設定できる
 - `サービスアカウントのキー`は、`Service Accounts`のページの`操作`の`鍵を作成`から生成が可能である  

## 環境変数を追加

仮に、`~/.var/My Project 54730-b57fa0611de1.json`が自分の`サービスアカウントの鍵`で有る際  
`export GOOGLE_APPLICATION_CREDENTIALS=$HOME/.var/"My Project 54730-b57fa0611de1.json"`  
のようになる。

## Gapps, APIのサービスアカウントの権限
Gapps, APIへのアクセス権限は明示的に与えなくても、なんの権限も付与していないサービスアカウントでアクセスできる  

