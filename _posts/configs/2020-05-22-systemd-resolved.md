---
layout: post
title: "systemd-resolved"
date: 2020-05-22
excerpt: "systemd-resolved"
tags: ["systemd-resolved", "linux", "ubuntu"]
config: true
comments: false
sort_key: "2021-11-25"
update_dates: ["2021-11-25","2021-11-23","2020-05-22"]
---

# systemd-resolved

## 概要
 - Ubuntu 20.04程度からDNSの設定がこのサービス経由で設定されている
 - stub listennerと呼ばれるキャッシュとして働くローカルDNSサーバを提供する

## 設定

### `/etc/systemd/resolved.conf`

例えば以下の設定は、DNSにリクエストを送りすぎて、通信が遅くなるのをCacheを有効化することで解消しようとした設定である  

そして実際に早くなる  

注意点として `ReadEtcHosts=no` を設定しておく必要があり、これを設定しないと `/etc/resolv.conf` が優先されてしまう  

また `DNSStubListener=yes` となっていると `port 53` を専有する `127.0.0.53` で受付するプロセスが起動するのでDNSサーバソフトウェア等と共存できない  

NOTE; IPが`127.0.0.1`ではなく、`127.0.0.53`でアクセスしないとアクセスできないので注意  

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
ReadEtcHosts=no
MulticastDNS=yes
#Domains=
#LLMNR=no
#DNSSEC=no
#DNSOverTLS=no
```

### stub listennerの設定確認

**設定の確認1**  
`/run/systemd/resolve/stub-resolv.conf` が以下のように設定されていれば、localhost(127.0.0.53)アクセス時にstub-listenner経由でのアクセスにできる

```
nameserver 127.0.0.53
options edns0
```

NOTE: `/etc/resolv.conf` の参照順位で例えば `1.1.1.1` などが `127.0.0.53` より早かったら stub-listennerを利用していないので高速化の恩恵が得られなくなる可能性がある

**設定の確認2**  
osがport 53をリッスンしていることでも確認できる  

```console
$ sudo lsof -i -P -n | grep LISTEN | grep :53
systemd-r  1055 systemd-resolve   13u  IPv4  47149      0t0  TCP 127.0.0.53:53 (LISTEN)
```

### stub listennerの使用上の注意
 - stub listennerは`127.0.0.53`からのアクセスで`port 53`で待ち受ける
 - `port 53`を使用するので`unbound`等のDNSサーバと共存することはできない

### 反映と確認

**再起動**  
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

**ローカルcacheが有効か確認**  
```console
$ dig @127.0.0.53 google.com
```


