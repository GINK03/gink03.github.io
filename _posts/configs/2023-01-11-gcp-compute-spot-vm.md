---
layout: post
title: "gcp cloud compute spot vm"
date: 2023-01-11
excerpt: "gcp cloud compute spot vmについて"
tags: ["cloud compute engine", "gcp", "spot vm", "preemptible"]
config: true
comments: false
sort_key: "2023-01-11"
update_dates: ["2023-01-11"]
---

# cloud compute spot vmについて

## 概要
 - `preemptible(プリエンプティブ)`という言い方もある
 - 値段が安いがGCPの都合でシャットダウンする
   - 1時間起動できないこともある
 - WebUIでspot vmを指定するのがわかりにくい

## WebUIでのspot vmの作成方法
 - `インスタンスを作成`
   - `詳細オプション`
     - `管理`
       - `可用性ポリシー`
         - `スポット`を選択

## コマンドでspot vmの作成方法

```console
$ gcloud compute instances create <vm-name> --preemptible
```

---

## 参考
 - [プリエンプティブル VM を作成して使用する/Google Cloud](https://cloud.google.com/compute/docs/instances/create-use-preemptible?hl=ja)
