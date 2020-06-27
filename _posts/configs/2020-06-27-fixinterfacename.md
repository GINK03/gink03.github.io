---
layout: post
title: "fix interface name"
date: 2020-06-27
excerpt: "fixinterfacename"
tags: [fix interface name]
config: true
comments: false
---

# fix interface name

PCI-E接続のNICやnvme SSDなどが接続されていると、NICの名前が変わることがある。

例えば、nvmeを接続すると、 `enp4s0` だったNICが１つインクリメントされて `enp5s0` とかになる。これはCPUやチップセットがデバイスを識別する順番に依存するようである。  

`/etc/netplan` とうに設定を記述していると、この名前が変化してしまうことが大変厄介で、macアドレスで固定ができるので、紹介する。 


##  /etc/udev/rules.d/70-persistent-net.rules を作成する

Ubuntu 20.04などではこのファイルを作成する事で、MACアドレスで、名前を指定することができる。  

`ATTR{address}="{MACADDR}"` , `NAME="{DEVICE_NAME}"` である
```console
SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="70:85:c2:c7:bb:dc" , ATTR{dev_id}=="0x0", ATTR{type}=="1", NAME="eth0"
SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="7c:fe:90:9e:45:d0" , ATTR{dev_id}=="0x0", ATTR{type}=="1", NAME="mellanox0"
```

