---
layout: post
title: "wakeonlan"
date: 2023-05-06
excerpt: "wakeonlanの使い方"
config: true
tag: ["linux", "windows", "wakeonlan"]
comments: false
sort_key: "2023-05-06"
update_dates: ["2023-05-06"]
---

# wakeonlanの使い方

## 概要
 - NICにmac addressを指定してPCを起動する機能/コマンド
 - BIOS/UEFIとOSの双方で有効化されている必要がある
 - UDPのポートが解放されていれば、インターネットからもスイッチを入れることができる
   - パケットがドロップされるのか、たまに通じないことが有る

## コマンドのインストール

**ubuntu/debian**
```console
$ sudo apt install wakeonlan
```

**macOS**
```console
$ brew install wakeonlan
```

## windowsでwakeonlanで待ち受けする
 - 手順
   - `デバイスマネージャー`を起動
   - `ネットワークアダプタ`を選択
   - `プロパティ`を選択
   - `電源の管理`のタブを選択
   - `このデバイスで、コンピューターのスタンバイ状態を解除できるようにする`を有効化
   - `Magic Packetでのみ、コンピュータのスタンバイ状態を解除できるようにする`を有効化

## ubuntuでwakeonlanで待ち受けをする

```console
# 確認
$ sudo ethtool <nic-name>
Supports Wake-on: <letters> # <letters>に`g`が含まれていればwolが動作する

# 有効化
$ sudo ethtool -s <nic-name> wol g
```

## wakeonlanで対象のPCを起動する

**LAN**
```console
$ wakeonlan <mac-address>
```

**インターネット**
```console
$ wakeonlan -i `dig +short <hostname>` -p <port> <mac-address> 
```

