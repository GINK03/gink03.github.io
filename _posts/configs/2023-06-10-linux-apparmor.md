---
layout: post
title: "linux apparmor"
date: 2023-06-10
excerpt: "linuxのAppArmorについて"
config: true
tag: ["linux", "apparmor", "selinux"]
comments: false
sort_key: "2023-06-10"
update_dates: ["2023-06-10"]
---

# linuxのAppArmorについて

## 概要
 - linuxの特にdebian, ubuntunにおいて利用されるセキュリティを高めるためのカーネルモジュール
 - プロファイルという事前に定義された設定で、アプリケーションごとにアクセスできる範囲を限定するもの
 - 無効化すると多少パフォーマンスが上がるらしい
   - unix benchではパフォーマンスの差が分からなかった

## ステータスの確認

```console
$ sudo aa-status
```

## AppArmorの停止

```console
$ sudo aa-teardown
$ sudo systemctl disable apparmor
$ sudo systemctl stop apparmor
```
