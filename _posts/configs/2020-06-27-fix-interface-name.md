---
layout: post
title: "インターフェイス名を固定する"
date: 2020-06-27
excerpt: "インターフェイス名を固定する方法"
tags: ["fix interface name"]
config: true
sort_key: "2021-07-09"
update_dates: ["2021-07-09","2020-06-27"]
comments: false
---

# インターフェイス名を固定する

## 概要
 - PCI-E接続のNICやnvme SSDなどが接続されていると、NICの名前が変わることがある。
    - PCI-Eの認識する順番に応じでNICの命名が行われるから
    - 例えば、nvmeを接続すると、 `enp4s0` だったNICが１つインクリメントされて `enp5s0` とかになる。これはCPUやチップセットがデバイスを識別する順番に依存するようである。  
 - `/etc/netplan` とうに設定を記述していると、この名前が変化してしまうことが大変厄介で、macアドレスで固定ができるので、紹介する。 

##  `/etc/udev/rules.d/70-persistent-net.rules` を作成し、名前を固定する
 - Ubuntuではではこのファイルを作成する事で、MACアドレスで、名前を指定することができる。  
 - `ATTR{address}="{MACADDR}"` , `NAME="{DEVICE_NAME}"` である

```console
SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="70:85:c2:c7:bb:dc" , ATTR{dev_id}=="0x0", ATTR{type}=="1", NAME="eth0"
SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="7c:fe:90:9e:45:d0" , ATTR{dev_id}=="0x0", ATTR{type}=="1", NAME="mellanox0"
```

