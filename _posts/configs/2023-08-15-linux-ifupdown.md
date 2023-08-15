---
layout: post
title: "linux ifupdown"
date: 2023-08-15
excerpt: "linuxのifupdownについて"
config: true
tag: ["linux", "ifupdown", "networking.service"]
comments: false
sort_key: "2023-08-15"
update_dates: ["2023-08-15"]
---

# linuxのifupdownについて

## 概要
 - linuxのサービスの`networking`を含むパッケージが`ifupdown`
   - `/etc/network/interfaces`での設定を行う際に必須になる 
 - `netplan`と`networking`は併用できる
 - 自動でLANポートが有効化されないケースがあり、`networking`を用いると自動で有効化できる

## インストールとサービスの有効化

**debian, ubuntu**
```console
$ sudo apt install ifupdown
```

**有効化と開始**
```console
$ sudo systemctl enable networking.service
$ sudo systemctl start networking.service
```

## `/etc/network/interfaces`の設定例
 - `enp0s3`は環境に応じて変更する

```config
auto lo
iface lo inet loopback

# autoで自動でLANポートが有効化される
auto enp0s3
iface enp0s3 inet dhcp
```
