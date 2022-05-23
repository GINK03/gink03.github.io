---
layout: post
title: "webshare.io"
date: 2021-07-30
excerpt: "webshare.io(proxyサービス)の使い方"
project: false
config: true
tag: ["webshare.io", "proxy"]
comments: false
sort_key: "2022-01-05"
update_dates: ["2022-01-05","2021-10-19","2021-07-30"]
---

# webshare.ioとは
 - プロキシのサブスクリプションサービス
 - 様々なサービスを比較検討したが、通信量に対する単価が比較的に安い

## socks5の利用が安定

## 正しくプロキシがワークしているかのチェック

### http

```console
$ curl -4 ifconfig.co -x <proxy-host-name>:<proxy-port>
<proxy-ip-address>
```

### socks5

```console
$ curl -4 ifconfig.co -x socks5://<username>:<password>@<proxy-host-name>:<proxy-port>
<proxy-ip-address>
```

