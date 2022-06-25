---
layout: post
title: "tailscale"
date: 2022-06-25
excerpt: "tailscaleの使い方"
tags: ["tailscale", "vpn", "wireguard"]
config: true
comments: false
sort_key: "2022-06-25"
update_dates: ["2022-06-25"]
---

# tailscaleの使い方

## 概要
 - hamachiのようなp2p VPN
   - シェアウェアである点もhamachiと似ている
 - wireguardをバックエンドに使用しており、認証関連をマネージしてくれるもの
   - wireguardは多少設定が面倒であるが、tailscaleを用いるとGoogle AccountやMicrosoft Accountでログインするだけで利用できる
 - UDP NAT traversalをサポートしており、NATの内側のコンピュータでもVPNネットワークに参加できる
 - 一定のコンピュータ数(20)までは無料なので、個人で利用するには十分そう
 - 登録しているコンピュータのIPアドレスは[Machines](https://login.tailscale.com/admin/machines)から確認できる

## インストール

**linux**
```console
$ curl -fsSL https://tailscale.com/install.sh | sh
$ sudo tailscale up
```

**macos**
 - `app store`から`tailscale`を検索してインストール

## 仮想インターフェイス
 - Linux
   - `tailscale0`
 - macOS
   - `utunX`

## ベンチマーク
 - VPNを接続してない場合に比べて、約パフォーマンスが54%に低下する

**直接接続した場合**
```console
$ netperf -H gimpeik.duckdns.org -t TCP_STREAM -v 2 -- -o mean_latency,throughput
MIGRATED TCP STREAM TEST from (null) (0.0.0.0) port 0 AF_INET to gimpeik.duckdns.org () port 0 AF_INET
Mean Latency Microseconds,Throughput
17474.43,58.68
```

**tailscaleのVPNを経由した場合**
```console
$ netperf -H 100.123.207.30 -t TCP_STREAM -v 2 -- -o mean_latency,throughput
MIGRATED TCP STREAM TEST from (null) (0.0.0.0) port 0 AF_INET to (null) () port 0 AF_INET
Mean Latency Microseconds,Throughput
33108.25,31.51
```

## tracerouteで中継サーバが無いか、確認する
 - ホップが存在しないので、本当に仲介を挟まずにアクセスできていそうである

```console
$ traceroute 100.123.207.30
traceroute to 100.123.207.30 (100.123.207.30), 64 hops max, 52 byte packets
 1  100.123.207.30 (100.123.207.30)  167.247 ms  43.860 ms  149.437 ms
```

## 参考
 - [/r/Tailscale/](https://www.reddit.com/r/Tailscale/)
 - [How to re-authenticate in Linux](https://github.com/tailscale/tailscale/issues/367)
