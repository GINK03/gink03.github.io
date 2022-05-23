---
layout: post
title: "ip addressについて"
date: "2021-12-08"
excerpt: "ip addressについて"
project: false
config: true
tag: ["linux", "ip address"]
comments: false
sort_key: "2021-12-08"
update_dates: ["2021-12-08"]
---

# ip addressについて

## アドレスクラス

 - クラスA
   - `0.0.0.0` ~ `127.255.255.255`
 - クラスB
   - `128.0.0.0` ~ `191.255.255.255`
 - クラスC
   - `192.0.0.0` ~ `223.255.255.255`
 - クラスD
   - `224.0.0.0` ~ `239.255.255.255`
 - クラスE
   - `240.0.0.0` ~ `255.255.255.255`

## ipv6のアドレス表記
 - 128bit長
 - 8bitごとに`:`で分割
 - 0が連続するところに限って一回だけ`::`と置き換えられる

## ipv6のループバックアドレス
 - `::1`
	
## ipv6の自動割当機能
 - `ra(router advertisement)`を利用してprefixの部分を自動で配布する
   - 後半のsuffixはmacアドレスから自動で生成する

## 参考
 - [IPv6アドレスの設定方法 ～手動/SLAAC/DHCPv6～](https://www.n-study.com/ipv6-detail/ipv6-address-configuration/)

