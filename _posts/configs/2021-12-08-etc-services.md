---
layout: post
title: "/etc/services"
date: "2021-12-08"
excerpt: "/etc/servicesについて"
project: false
config: true
tag: ["linux", "/etc/services", "netstat"]
comments: false
---

# /etc/servicesについて

## 概要
 - well-knownのサービス名とポート/プロトコルを対応させ、名前解決を可能にする

## 具体例

```console
$ less /etc/services
...
ssh             22/tcp                          # SSH Remote Login Protocol
...
domain          53/tcp                          # Domain Name Server
domain          53/udp
...
http            80/tcp          www             # WorldWideWeb HTTP
```

## 名前解決する具体例

```console
$ netstat -atu
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address               Foreign Address             State
tcp        0      0 0.0.0.0:ssh                 0.0.0.0:*                   LISTEN
tcp        0      0 0.0.0.0:smtp                0.0.0.0:*                   LISTEN
```

## 参考
 - [「/etc/services」ファイル](https://linuc.org/study/knowledge/511/)
