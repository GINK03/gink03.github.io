---
layout: post
title: "gcp cloud shell"
date: "2022-05-25"
excerpt: "gcp cloud shellの使い方"
project: false
config: true
tag: ["gcp", "gcloud", "cloud shell"]
comments: false
sort_key: "2022-05-25"
update_dates: ["2022-05-25"]
---

# gcp cloud shellの使い方

## 概要
 - 無料で使えるGCPの環境設定・構築用のシェル
 - `/home`以下に永続ディスクが割り当てられている
   - 5GBの永続ディスクが割り当てられる
 - debian linuxベースのものがインストールされている
 - cloud memorystoreなど同じネットワーク内で動作することを期待するサービスへのアクセスは、gloud shellからだとできない

## 手元のterminalからログイン

```console
$ gcloud cloud-shell ssh
```

## 参考
 - [Cloud Shell の仕組み/Google Cloud](https://cloud.google.com/shell/docs/how-cloud-shell-works)


