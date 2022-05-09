---
layout: post
title: "wireguard"
date: 2021-02-09
excerpt: "wireguardの使い方"
tags: ["vpn", "network", "wireguard"]
config: true
comments: false
---

# wireguardの使い方

## 概要
 - Linux Kernel 5.6から導入されたVPN
 - Endpointとしてipv6を用いることもでき、このとき実質的にipv4 over ipv6(IPoE)接続になり、高速化が期待できることもある

## 注意
 - AMD Ryzenの乱数発生が正しく動作しないという問題の影響を受ける
   - mainboardのUEFIの最新化で正常化することができる
 - 殆どの操作が`root`を期待している
 - `PostUp`で記すscriptは正常に動作しないことがある。その場合、別途、そのスクリプトは実行する必要がある

## install

**debian**

```console
$ echo "deb http://deb.debian.org/debian buster-backports main" | sudo tee /etc/apt/sources.list.d/buster-backports.list
$ sudo apt install update
$ sudo apt install wireguard
```

## key generate
 - 秘密鍵、公開鍵を作る

**秘密鍵**   
```console
# wg genkey > privatekey
```

**公開鍵**  
```console
# wg pubkey < privatekey > publickey
```

## server setup

```console
# cd /etc/wireguard
# touch wg0.conf
```

## example server wg0.conf

```
[Interface]
Address = 192.168.0.1/24
SaveConfig = true
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o mellanox0 -j MASQUERADE; ip6tables -A FORWARD -i wg0 -j ACCEPT; ip6tables -t nat -A POSTROUTING -o mellanox0 -j MASQUERADE
ListenPort = 41194
PrivateKey = 6LHnxqrlI/La9/jU*******ufUaGg=

[Peer]
PublicKey = VRu+7scEAwQinRwlOiGvZili5AlIghdcmAF1KkRWryk=
AllowedIPs = 192.168.0.4/32
Endpoint = 126.133.200.64:1900

[Peer]
PublicKey = H/mcwTJnYM5VgR2J+DqTnLOq7Wj/fl4v1nt2XQidXm8=
AllowedIPs = 192.168.0.5/32, 2a03:b0c0:2:f0::2c:2005/128
Endpoint = 126.133.200.64:1395
```

 - この設定は`wg-quick down wg0`するたびに、プログラムによって上書きされるので、`wg-quick down wg0`してから編集する
 - `PostUp`はIFのアップ時に走るスクリプト。この例ではIP 4, IP 6を`mellanox0`デバイス側に向けてnatで転送する　
   - 一部の環境ではこの転送ルールは動かないので、別途スクリプトを分けて実行する必要がある
 - `PostDown`で`iptables`コマンドで解除しているスクリプトもあるが、適応すると何度もコマンドが打たれることになり、serverサイドが不安定になった
 - `[Peer]のPublicKey`はクライアントのMacOSXやiPhoneから発行される公開鍵。いちいちコピペするのが大変
 - `[Peer]のAllowdIPs`はクライアントが接続してきたらどのIPアドレスならば許可するかを示すもの。クライアント側の設定と食い違うと通信できない
 - `Endpoint`は設定しなくても自動で生成される。また、これでアクセス元を制限できる等のものでもない

## enable server side ip forwarding
 - debian, ubuntu系では以下の設定を入れないとIPのフォワードをしない
 - この設定は再起動すると消えてしまうので、起動スクリプトに入れるなどの工夫が必要
   - より詳細な設定については[/sysctl/](/sysctl/)を参照

```console
# sysctl -w net.ipv4.ip_forward=1
# sysctl -w net.ipv6.conf.all.forwarding=1
```

## example up/donw wg0

```console
# wg-quick up wg0 # 起動
# wg-quick down wg0 # 停止
# wg # ステータス表示
```
 - `wg`コマンドでどのピアが接続しているかがわかる
 - サーバ側の`PublicKey`は`wg`コマンドで確認することができる

**wgコマンドで通信状況を確認した例**

<div>
  <img style="align: center !important; width: 300px !important;" src="https://user-images.githubusercontent.com/4949982/107497755-4a615c00-6bd6-11eb-8218-c5d7f795bfb4.png">
</div>

transferで通信量が見えるので、疎通は行われていることがわかる

## systemdでサービス登録する

```console
# systemctl start wg-quick@wg0
# systemctl enable wg-quick@wg0
```

## example client conf

```
[Interface]
PrivateKey = 2CYUPIwWR*******4vrUVOxDeyxm7EDq7m+l38=
Address = 192.168.0.5/32, 2a03:b0c0:2:f0::2c:2005/64
DNS = 1.1.1.1

[Peer]
PublicKey = a0nUQiZOtAbpsX7l1VLpA5TOQlKcL9yPCA47QXo5hDw=
AllowedIPs = 0.0.0.0/0, ::0/0
Endpoint = 192.168.40.23:41194 # IPv4で接続するとき
Endpoint = [2001:19f0:7002:dcd:5400:3ff:fe86:a14f]:41194 # IPv6で接続するとき
PersistentKeepalive = 1
```
 - `[Interface]のAddress`のネットマスクは32のプレフィックスで与えないと他のノードが繋げなくなる
 - `[Peer]のPublicKey`はサーバの公開鍵を設定する
 - `[Peer]のAllowdIPs`は`0.0.0.0/0`とすると全ての通信をwireguard経由で通信することになる
   - `::0/0`はすべてのIPv6パケットもトンネリングする、ということ 


**MacOSXでの設定**  
 - `AppStore`に[WireGuard](https://apps.apple.com/jp/app/wireguard/id1451685025?mt=12)のクライアントソフトがある
 - ソフトウェに`example client conf`の設定を記入して設定を行う

**iPhoneでの設定**
 - `AppStore`にWireGuardのクライアントソフトがある
 - コピペしづらいので設定が大変である

