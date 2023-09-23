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
 - Ubuntu 20.04からDNSの設定がこのサービス経由で設定される
 - 一時的には`/etc/resolv.conf`を直接変更することを許容しているが、恒久的に変更するには`/etc/systemd/resolved.conf`を変更する
 - stub listennerと呼ばれるキャッシュとして働くローカルDNSサーバを提供する
   - stub listennerが不具合を起こすことも有り、その場合は無効化することもできる

## 設定
 - 設定ファイルのパス
   - `/etc/systemd/resolved.conf`

### 設定例; stub listennerの明示的な無効化
 - 以下の設定は、stub listennerを無効化する設定である
 - これを設定すると設定したDNSサーバに対してのみ問い合わせを行うようになる

```config
[Resolve]
DNS=1.1.1.1 # unboundなどを使用している場合は 127.0.0.1 にする
FallbackDNS=8.8.8.8
DNSStubListener=no
```

### 設定例; stub listennerの有効化
 - 例えば以下の設定は、DNSにリクエストを送りすぎて、通信が遅くなるのをCacheを有効化することで解消しようとした設定である  
 - 実際に早くなる  
 - 注意点として `ReadEtcHosts=no` を設定しておく必要があり、これを設定しないと `/etc/resolv.conf` が優先されてしまう  
 - また `DNSStubListener=yes` となっていると `port 53` を専有する `127.0.0.53` で受付するプロセスが起動するのでDNSサーバソフトウェア等と共存できない  
 - NOTE; IPが`127.0.0.1`ではなく、`127.0.0.53`でアクセスしないとアクセスできないので注意  

```config
[Resolve]
DNSStubListener=yes
Cache=yes
DNS=1.1.1.1
FallbackDNS=8.8.8.8
ReadEtcHosts=no
MulticastDNS=yes
```

## 反映と確認

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
