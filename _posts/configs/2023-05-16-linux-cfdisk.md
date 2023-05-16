---
layout: post
title: "linux cfdsik"
date: 2023-05-16
excerpt: "linuxのcfdiskについて"
config: true
tag: ["linux", "cfdisk"]
comments: false
sort_key: "2023-05-16"
update_dates: ["2023-05-16"]
---

# linuxのcfdiskについて

## 概要
 - cfdisk - display or manipulate a disk partition table
 - fdiskよりわかりやすいパーティションツール
 - CLIで使えるが、選択式なのでコマンドを覚える必要がない

## インストール

```console
$ sudo apt install util-linux
```

## 起動方法

```console
$ sudo cfdisk /dev/<device>
```
