---
layout: post
title: "SoftEtherとそのエコシステム"
date: 2022-04-24
excerpt: "SoftEtherとそのエコシステムについて"
project: false
config: true
tag: ["softether", "packetix", "vpn", "ssl-vpn"]
comments: false
---

# SoftEtherとそのエコシステムについて

## 概要
 - 日本製のVPNサーバ、クライアントソフトウェア
 - SoftEtherとPacketiXというブランドがあるが、SoftEtherが研究目的でPacketiXが商用という位置づけ
 - [vpngate.net](https://www.vpngate.net/ja/)という実験ネットワークが公開されており、だれでも参加できる
   - 国内のノードが多く、他の公開リストのネットワークに比べて安定している
 - VPNのプロトコルは`SSL-VPN`, `L2TP SoftEther`という規格
 - サーバ、クライアントともにWindowsと相性がいい

## 公開ネットワークのアクセスアドオンを含んだVPNクライアント
 - [VPN Gate Client download (for Windows, freeware)](https://www.vpngate.net/en/download.aspx)


## サードパーティが提供するVPNサーバ

### [VPNJANTIT](https://www.vpnjantit.com/free-softether-l2tp-india) 
 - インドのVPNサーバ
 - ポイントを買って数時間のアクセス権を得ることができる
 - 数時間だけVPNを使用したいときに便利

## サイトのアクセス国の判定ロジック
 - `IPv6の示す地域名 > IPv4の示す地域名`である

## 参考
 - [Youtubeプレミアムを安くする方法は違法【インドVPN】](https://kikankou.co.jp/vpn/youtube-premium-vpn-india/)
   - 法律ではないが、規約で禁止されており、特定のサービスをVPNを介して利用することで損害を与えてはならない
