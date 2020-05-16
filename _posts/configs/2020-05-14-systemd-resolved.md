---
layout: post
title: "systemd-resolved"
date: 2020-05-14
excerpt: "line"
tags: [systemd-resolved]
config: true
comments: false
---

# systemd-resolved
Ubuntu 20.04程度からDNSの設定がこのサービス経由で設定されている

## /etc/systemd/resolved.conf

例えば以下の設定は、DNSにリクエストを送りすぎて、通信が遅くなるのをCacheを有効化することで解消しようとした設定である  

そして実際に早くなる

```
#  This file is part of systemd.
#
#  systemd is free software; you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by
#  the Free Software Foundation; either version 2.1 of the License, or
#  (at your option) any later version.
#
# Entries in this file show the compile time defaults.
# You can change settings by editing this file.
# Defaults can be restored by simply deleting this file.
#
# See resolved.conf(5) for details

[Resolve]
DNSStubListener=yes
Cache=yes
DNS=1.1.1.1
FallbackDNS=8.8.8.8
#Domains=
#LLMNR=no
#MulticastDNS=no
#DNSSEC=no
#DNSOverTLS=no
#DNSStubListener=yes
#ReadEtcHosts=yes
```

## stub listennerの設定確認

`/run/systemd/resolve/stub-resolv.conf` が以下のように設定されていれば、localhost(127.0.0.53)アクセス時にstub-listenner経由でのアクセスにできる

```
nameserver 127.0.0.53
options edns0
```

NOTE: `/etc/resolv.conf` の参照順位で例えば `1.1.1.1` などが `127.0.0.53` より早かったら stub-listennerを利用していないので高速化の恩恵が得られなくなる可能性がある


## 反映と確認

```console
$ sudo systemctl restart systemd-resolved
```

**status**
```console
$ sudo systemd-resolve --status
```

**statistics**
```console
$ sudo systemd-resolve --statistics
```


