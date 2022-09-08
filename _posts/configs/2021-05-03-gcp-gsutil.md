---
layout: post
title: "gcp gsutil"
date: 2021-05-03
excerpt: "gcp gsutilコマンドの使い方"
tags: ["gcp", "gsutil", "gcloud"]
config: true
comments: false
sort_key: "2021-05-03"
update_dates: ["2021-05-03"]
---

# gsutilコマンド

## 概要
 - `google-cloud-sdk(gcloud)`をインストールすると自動的に入る  
 - `gcloud`ツールの一部
   - gcloudと認証情報を共有しており、gcloudでログインしているアカウントで操作可能
 - 主に`cloud storage`のマネージメントを行えるツール

## バケットの作成

```console
$ gsutil mk gs://$BUCKET_NAME
```

## サブディレクトリの作成
 - 基本的にサブディレクトリの作成機能は持たないが、ワークアラウンドで対応できる

```console
$ mkdir $NAME
$ touch $NAME/tmp
$ gsutil cp -r $NAME gs://$BUCKET_NAME
```

## 大量のチャンクファイルのコピー
 - `-m`オプションを`gsutil`のコマンドにつけると並列コピーが可能になる

```console
$ gsutil -m cp -r gs://$BUCKET_NAME .
```
