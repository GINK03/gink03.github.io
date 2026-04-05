---
layout: post
title: "pacemaker"
date: 2022-06-26
excerpt: "pacemakerの使い方"
tags: ["pacemaker"]
config: true
comments: false
sort_key: "2022-06-26"
update_dates: ["2022-06-26"]
---

# pacemakerの使い方

## 概要
 - HAクラスタソフト
 - 2010年代前半に人気の技術で現在はk8s
 - `pcs`は`pacemaker configuration tool`の略

## インストール

**ubuntu**  
```console
$ sudo apt install pcs pacemaker fence-agents
```

## セットアップ

**サービスの開始**  
```console
$ sudo systemctl start pcsd.service
$ sudo systemctl enable pcsd.service
```

**haclusterというユーザにパスワードの設定**  
```console
# passwd hacluster
```

**ノードへの認証**  
```console
# pcs host auth <node-host>
```

**クラスタの作成と起動**  
```console
# pcs cluster setup my_cluster --start <node-host>
```

**クラスタのステータスの確認**  
```console
# pcs cluster status
```

## 参考
 - [Pacemakerの概要/LINUX-HA JAPAN](https://linux-ha.osdn.jp/wp/manual/pacemaker_outline)
 - [第2章 Pacemaker の使用の開始](https://access.redhat.com/documentation/ja-jp/red_hat_enterprise_linux/8/html/configuring_and_managing_high_availability_clusters/assembly_getting-started-with-pacemaker-configuring-and-managing-high-availability-clusters)
