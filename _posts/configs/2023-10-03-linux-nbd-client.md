---
layout: post
title: "linux nbd-client"
date: 2023-10-03
excerpt: "linuxのnbd-clientについて"
config: true
tag: ["network block device", "nbd", "nbd-client", "linux"]
comments: false
sort_key: "2023-10-03"
update_dates: ["2023-10-03"]
---

# linuxのnbd-clientついて

## 概要
 - ネットワーク経由でブロックデバイスを提供するサービス・プロトコル
 - 低いレイヤーで動作するので、ファイルシステムの種類に依存しない
 - クライアントとサーバーでパッケージが異なる
 - 複数のデバイスで同一のブロックデバイスを共有できるが制限がある
   - サーバで`readonly = true`でありクライアントで`ro`での共有は可能

## インストールとセットアップ

**debian, ubuntu**
```console
$ sudo apt install nbd-client
$ sudo modprobe nbd # nbdモジュールのロード
```

## エクスポート名を指定して接続
 - エクスポート名とはserver側での設定ブロックの名前のこと
 - 複数の設定がある場合は、`nbd-client`コマンドの`-N`オプションで指定する

```console
$ sudo nbd-client -N <export-name> <ip-address> /dev/nbd0
```

## 接続を解除

```console
$ sudo nbd-client -d /dev/nbd0
```

## 使用例

### 接続したnbdをbtrfsでフォーマットしマウント

```console
$ sudo mkfs -t btrfs -f /dev/nbd0
$ sudo mount /dev/nbd0 /path/to/mount
```
