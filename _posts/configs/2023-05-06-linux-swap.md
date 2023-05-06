---
layout: post
title: "linux swap"
date: 2023-05-06
excerpt: "linuxのswapについて"
config: true
tag: ["linux", "swap"]
comments: false
sort_key: "2023-05-06"
update_dates: ["2023-05-06"]
---

# linuxのswapについて

## 概要
 - macOSのswapのように使用できる

## swapfileサイズの基準
 - 8G以上の物理メモリでは、実メモリの半分程度が目安

## swapfileを削除する
 - `/swapfile`にswapfileが存在する場合

```console
$ sudo swapoff -a
$ sudo rm /swapfile
```

## swapfileを作成する
 - `/swapfile`に32Gのswapfileを作成する場合

```console
$ sudo fallocate -l 32G /swapfile
$ sudo chmod 600 /swapfile
$ sudo mkswap /swapfile
$ sudo swapon /swapfile
$ echo '/swapfile swap swap defaults 0 0' | sudo tee -a /etc/fstab # fstabに情報がない場合
```
