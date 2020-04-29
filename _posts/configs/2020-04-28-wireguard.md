---
layout: post
title: "wireguard"
date: 2020-04-28
excerpt: "wireguard"
tags: [wireguard]
config: true
comments: false
---

# wireguard
## 概要
 - Linux Kernel 5.6から導入されたVPN

## 注意
 - AMD Ryzen 3000の乱数発生が正しく動作しないという問題の影響を受ける
 - mainboardのUEFIの最新化で正常化することができる

## key generate
 - 秘密鍵、公開鍵を作る

**秘密鍵**   
```console
$ wg genkey > privatekey
```

**公開鍵**  
```console
$ wg pubkey < privatekey > publickey
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
PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o enp9s0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o enp9s0 -j MASQUERADE
ListenPort = 41194
PrivateKey = 6LHnxqrlI/La9/jU*******ufUaGg=

[Peer]
PublicKey = VRu+7scEAwQinRwlOiGvZili5AlIghdcmAF1KkRWryk=
AllowedIPs = 192.168.0.4/32
Endpoint = 126.133.200.64:1900

[Peer]
PublicKey = H/mcwTJnYM5VgR2J+DqTnLOq7Wj/fl4v1nt2XQidXm8=
AllowedIPs = 192.168.0.3/32
Endpoint = 126.133.200.64:1395
```

## example up/donw wg0

```console
# wg-quick up wg0 # 起動
# wg-quick down wg0 # 停止
# wg # ステータス表示
```

## example client conf

Addressのネットマスクは32のプレフィックスで与えないと他のノードが繋げなくなる

```
[Interface]
PrivateKey = KHUrJvK2K2wnh9+1DyyqjXXiRvwHPWH474UtBd3vjH4=
Address = 192.168.0.4/32
DNS = 1.1.1.1

[Peer]
PublicKey = a0nUQiZOtAbpsX7l1VLpA5TOQlKcL9yPCA47QXo5hDw=
AllowedIPs = 192.168.0.1/24
Endpoint = 118.241.158.51:41194
PersistentKeepalive = 1
```

## すべての通信をトンネリングする

AllowdIPsのレンジを0.0.0.0/0などとして、広げればいいだけ

```
[Interface]
PrivateKey = KHUrJvK2K2wnh9+1DyyqjXXiRvwHPWH474UtBd3vjH4=
Address = 192.168.0.4/32
DNS = 1.1.1.1

[Peer]
PublicKey = a0nUQiZOtAbpsX7l1VLpA5TOQlKcL9yPCA47QXo5hDw=
AllowedIPs = 0.0.0.0/0
Endpoint = 118.241.158.51:41194
PersistentKeepalive = 1
```

## systemdでサービス登録する

```console
# systemctl start wg-quick@wg0
# systemctl enable wg-quick@wg0
```

