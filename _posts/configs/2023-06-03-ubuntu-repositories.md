---
layout: post
title: "ubuntu repositories"
date: 2023-06-03
excerpt: "ubuntuのレポジトリについて"
tags: ["ubuntu", "linux", "repositories"]
config: true
comments: false
sort_key: "2023-06-03"
update_dates: ["2023-06-03"]
---

# ubuntuのレポジトリについて

## 概要
 - ubuntuのソフトウェアや更新のバイナリはレポジトリに管理されている
 - レポジトリのURLは`/etc/apt/sources.list`に平文で記述されている
 - どこのサーバを参照するかで速度が大きく異なる
   - `jp.archive.ubuntu.com`
     - 遅い
   - `archive.ubuntu.com`
     - 時間帯によっては遅い
   - `ftp.udx.icscoe.jp/Linux`
     - 早い
     - 秋葉原のUDXにサーバが有るらしい
 - レポジトリの回線の太さは以下のリンクの表に記されている
   - [Official Archive Mirrors for Ubuntu](https://launchpad.net/ubuntu/+archivemirrors)

## `aruchive.ubuntu.com`を`ftp.udx.icscoe.jp/Linux`に変える
 - vim等で`/etc/apt/sources.list`を開く
 - `:s/archive.ubuntu.com/ftp.udx.icscoe.jp\/Linux/g`
 - `:s/security.ubuntu.com/ftp.udx.icscoe.jp\/Linux/g`

## 参考
 - [Ubuntu aptが遅かったので jp.archive.ubuntu.com を変更](https://kuni92.net/2022/10/ubuntu-apt-jparchiveubuntucom.html)
