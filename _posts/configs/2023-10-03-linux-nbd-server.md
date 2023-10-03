---
layout: post
title: "linux nbd-server"
date: 2023-10-03
excerpt: "linuxのnbd-serverについて"
config: true
tag: ["network block device", "nbd", "nbd-server", "linux"]
comments: false
sort_key: "2023-10-03"
update_dates: ["2023-10-03"]
---

# linuxのnbd-serverについて

## 概要
 - ネットワーク経由でブロックデバイスを提供するサービス・プロトコル
 - 低いレイヤーで動作するので、ファイルシステムの種類に依存しない
 - NFSは複数のデバイスからの同時読み書きを期待できるが、NBDは書き込みは一つのクライアントからのみとなる
   - 読み込みは複数のクライアントから可能

## インストール

**debian, ubuntu**
```console
$ sudo apt install nbd-server
```

## 権限関連の設定
 - デフォルトでは`user:group`が`nbd:nbd`なので適宜グループを変更する
 - 以下はnbdgroupというgroupを作成し、userとnbdを加える例

```console
$ sudo groupadd nbdgroup
$ sudo usermod -aG nbdgroup user
$ sudo usermod -aG nbdgroup nbd
```

## 共有するimgファイルの作成

```console
$ dd if=/dev/zero of=hoge.img bs=1G count=10
$ sudo chgrp nbdgroup /path/to/hoge.img
$ sudo chmod g+rw /path/to/hoge.img
```

## 設定

```config
[generic]
    user = nbd
    group = nbdgroup
    includedir = /etc/nbd-server/conf.d

[hoge]
    exportname = /path/to/hoge.img
    allowlist = 138.2.4.0/24, 192.168.1.0/24
    readonly = false
```

## 起動

```console
$ sudo systemctl enable nbd-server
$ sudo systemctl start nbd-server
```

## 参考
 - [ディスクレスシステム - archwiki](https://wiki.archlinux.jp/index.php/%E3%83%87%E3%82%A3%E3%82%B9%E3%82%AF%E3%83%AC%E3%82%B9%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0)
