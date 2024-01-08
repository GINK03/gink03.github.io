---
layout: post
title: "debian"
date: 2024-01-09
excerpt: "debianのbackportsについて"
tags: ["debian", "linux"]
config: true
comments: false
sort_key: "2024-01-09"
update_dates: ["2020-01-09"]
---

# debianのbackportsについて

## 概要
 - `backports`とは、debianの安定版に対して、新しいソフトウェアを提供するリポジトリ
 - 最新のソフトウェアを使いたい場合に利用する

## backportsの利用方法
 - `/etc/apt/sources.list`に追記する
 - bookwormは適宜読み替える

```
deb http://deb.debian.org/debian bookworm-backports main non-free-firmware
deb-src http://deb.debian.org/debian bookworm-backports main non-free-firmware
```

## 最新のカーネルをインストールする

```console
$ sudo apt -t bookworm-backports install linux-image-amd64
```
