---
layout: post
title: "各種OSのインターフェースのIPアドレスを固定する"
date: 2017-04-02
excerpt: "各種OSのインターフェースのIPアドレスを固定する方法"
config: true
tag: ["ubuntu", "debian", "windows"]
sort_key: "2018-01-19"
update_dates: ["2022-06-15", "2018-01-19"]
comments: false
---

# 各種OSのネットワークインターフェースのIPアドレスを固定する方法

## 概要
 - ubuntuにおいては `NetworkManager` がインストールされているか, `netplan` は使えるか、などで設定の方法が変化し、状況に応じた設定が必要になる
 - Windowsにおいては[/powershell/](/powershell/)を用いることで特定のIPアドレスを付与できる

## ubuntu, debian(NetworkManagerがアクティブな場合)
 - NetworkManagerがアクティブかどうかは以下のコマンドで確認できる
   - `systemctl status NetworkManager`
 - `nmtui`というコマンドでIPアドレスを設定できる

## ubuntu(netplanに対応している場合)
 - `NetworkManager`が無効化されていると`networkd`が代わりにインターフェースを管理する 
 - 具体的な使い方は[/netplan/](/netplan/)を参考

## debian
 - `/etc/network/interfaces`を編集することで結果を得ることができる  
 - たとえば以下のような設定をしたら、IPが`192.168.1.50`に固定される  

```config
auto eth0
allow-hotplug eth0
iface eth0 inet static
address 192.168.1.50
netmask 255.255.255.0
gateway 192.168.1.1
dns-nameservers 192.168.1.1
```

## Windows
 - インターフェイス番号を取得
   - `> Get-NetIPConfiguration`
 - `192.168.40.16/24`をインターフェースインデックス`23`に追加する例
   - `> New-NetIPAddress -InterfaceIndex 23 -IPAddress 192.168.40.16 -PrefixLength 24`