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
   - 一部GUIがシェアウェアである点もhamachiと似ている
 - wireguardをバックエンドに使用しており、認証関連をマネージしてくれるもの
   - wireguardは多少設定が面倒であるが、tailscaleを用いるとGoogle AccountやMicrosoft Accountでログインするだけで利用できる
   - デフォルトでは一定期間でkey expireするので、無効化するにはWebUIから`disable key expiry`を選択する
 - UDP NAT traversalをサポートしており、NATの内側のコンピュータでもVPNネットワークに参加できる
 - 一定のコンピュータ数(20)までは無料なので、個人で利用するには十分そう
 - 登録しているコンピュータのIPアドレスは[Machines](https://login.tailscale.com/admin/machines)から確認できる
 - ある程度のオーバーヘッドがあり、速度が半分程度になる
 - コントロールプレーンというマネージをするサーバが必要で、無料で使うにはこれが制限となる
   - 半年に一度認証が解除されるのでいざというときに使えないのが痛い
 - [headscale](https://github.com/juanfont/headscale)というコントロールプレーンをセフルホストにするOSSもある
 - exit nodeを指定・利用することできる
   - VPNをトンネリングで利用しているイメージですべてのトラヒックをexit node経由で行うことができる
 - relayモードとdirectモードがあり、directモードはとても早いが`41641/udp`の開放が必要になる
   - 手動でポートを変更したい場合は`/etc/default/tailscaled`を編集すれば良い
   - 同じサブネットに複数のtailscaleのノードがあったとしてもポートを自動調整するので原則として変更する必要はない
 - directモードを確立できない場合、世界中に配置されたDERPと呼ばれる公開サーバをリレーとしてフォールバックする
   - `tailscale status`で接続状況を確認できる
     - `relay "tok"`であれば東京のリレーサーバを経由している

## ユースケース
 - ファイヤーウォールの内部に設定したセキュアな環境にアクセスする
   - ssh
     - グローバルIPの設定がいらない
   - jupyter
     - 踏み台の設定がいらないので楽

## インストール

**linux**
```console
$ curl -fsSL https://tailscale.com/install.sh | sh
$ sudo tailscale up
```

**macos**
 - `app store`から`tailscale`を検索してインストール
 - app store版ではCLIは入らない

**macOSにビルドしてインストール/アップデート**
```console
$ go install tailscale.com/cmd/tailscale{,d}@main
$ sudo $HOME/.go/bin/tailscaled install-system-daemon # launchdに登録
```

## tailscale ping
 - tailscale上でのネットワークのネゴシエーションを含んだpingを行う
 - replayモードからdirectモードに変更するためにも使用できる

```console
$ tailscale ping 100.108.132.113
pong from kichijouji (100.108.132.113) via DERP(tok) in 39ms
pong from kichijouji (100.108.132.113) via 211.15.239.222:41641 in 38ms
```

## FOSSバージョンのheadscaleについて
 - 概要
   - tailscaleのFOSS
   - tailscaleのコントロールプレーンのみをself hostにすることで完全に無料にしている
   - インストールのハードルが高い
     - dockerで管理するのがよい

## 仮想インターフェイス
 - Linux
   - `tailscale0`
 - macOS
   - `utunX`

## 現在アクティブなデバイスの一覧と接続形式を表示

```console
$ tailscale status
```
 - 接続可能なデバイスの一覧を表示できる
 - メニューバーやタスクトレイから確認するより早い
 - 通信方式の確認
   - `relay <tok>`のような表示のときrelayサーバ経由でのアクセス
   - `direct 211.15.239.222:15968`のような表示のときdirectアクセス

## ベンチマーク
 - relayサーバ経由だと、約パフォーマンスが54%に低下する

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

## exit nodeの設定
 - tailscaleのルーティングするデバイスを指定してexit nodeにすることができる
   - exit nodeはルータみたいなイメージ

**linuxをexit nodeとしての設定**
```console
$ echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.conf
$ echo 'net.ipv6.conf.all.forwarding = 1' | sudo tee -a /etc/sysctl.conf
$ sudo sysctl -p /etc/sysctl.conf
$ sudo tailscale up --advertise-exit-node
```

**macOSでexit nodeを利用する**
 - tailscaleのアイコンをクリック
 - `Exit Node`を選択

**linuxでexit nodeを利用する**
```console
$ sudo tailscale up --exit-node=<exit-node-ip>
```

## tracerouteで中継サーバが無いか、確認する
 - ホップが存在しないので、本当に仲介を挟まずにアクセスできていそうである

```console
$ traceroute 100.123.207.30
traceroute to 100.123.207.30 (100.123.207.30), 64 hops max, 52 byte packets
 1  100.123.207.30 (100.123.207.30)  167.247 ms  43.860 ms  149.437 ms
```

## トラブルシューティング
 - direct connectionが利用できない
   - 原因
     - 接続クライアント側(ノートパソコン等)で公衆無線LANなどを利用していると、ルーターの制限のためか、directモードが確立できないことがあった

## 参考
 - [/r/Tailscale/](https://www.reddit.com/r/Tailscale/)
 - [Tailscaled on macOS](https://github.com/tailscale/tailscale/wiki/Tailscaled-on-macOS)
 - [How to re-authenticate in Linux](https://github.com/tailscale/tailscale/issues/367)
