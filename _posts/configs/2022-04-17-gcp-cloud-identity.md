---
layout: post
title: "gcp cloud identity"
date: 2022-04-17
excerpt: "gcp cloud identityの使い方"
project: false
config: true
tag: ["gcp", "cloud identity"]
comments: false
---

# gcp cloud identityの使い方

## 概要
 - IDaaS(Identity as a Service)の一種で、oktaのようなサービス
 - メールとカレンダーが無い無料版と、制限がない有料版がある
 - 登録には独自ドメインが必要(Dynamic DNSでも登録できる)
 - 作成したCloud Identityの管理は[admin.google.com](https://admin.google.com/u/3/)から行える

## アプリをリンクする
 1. 管理者の画面からマーケットプレイス(リンク可能なアプリのマーケット)を標示する
 2. 必要なアプリをインストール

### マーケットプレイスにあるアプリの例
 - zoom
 - slack
 - trello
 - asana
 - dropbox
 - box
 - adobe

## 参考
 - [無料で使えるGoogleのIDaaS「Google Cloud Identity Free Edition」を利用してみた](https://dev.classmethod.jp/articles/getting-started-google-cloud-identity/)
