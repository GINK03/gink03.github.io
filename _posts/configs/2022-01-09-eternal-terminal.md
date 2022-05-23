---
layout: post
title: "eternal-terminal"
date: "2022-01-09"
excerpt: "eternal-terminalの使い方"
project: false
config: true
tag: ["ssh", "terminal", "eternal-terminal"]
comments: false
sort_key: "2022-02-16"
update_dates: ["2022-02-16","2022-01-09"]
---

# eternal-terminalの使い方

## 概要
 - Eternal TCP is a layer in between an application and unix TCP sockets that make the sockets robust to TCP disconnects including roaming and connection failure
 - roamingと再開可能なtcpでの接続を行うsshラッパー
 - jumphost(踏み台サーバを透過的に扱う)
 - レンジベースのポートフォワーディングができる
   - 現状、sshコマンドはレンジベースのポートフォワーディングをサポートしていない

## インストール

**ubuntu**  
```console
$ sudo add-apt-repository ppa:jgmath2000/et
$ sudo apt-get update
$ sudo apt-get install et
```

**osx**  

```console
$ brew install MisterTea/et/et
``` 
 - インストールに失敗する場合`protocolbuffer`を手動でインストーするする必要がある

## 接続

### 通常(port 2022)で接続

```console
$ et <hostname>
```

## 具体例

### 踏み台サーバを経由して接続

```console
$ et <hostname> --jumphost <step-server>
```
 - jumphostとポートフォワーディングは併用できる

### レンジベースのポートフォワーディング

```console
$ et <hostname> -t 8888-9000:8888-9000
```

### 家のPCにステップサーバを利用してアクセスしjupyterをポートフォーワードする

```console
$ et 192.168.40.24 --jumphost gimpeik.duckdns.org -t 8888-9000:8888-9000
```

## 参考
  - [github.com/MisterTea/EternalTerminal](https://github.com/MisterTea/EternalTerminal)
  - [Eternal Terminal](https://eternalterminal.dev/)
