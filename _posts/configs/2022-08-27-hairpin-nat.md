---
layout: post
title: "hairpin NAT(NATループバック)"
date: 2022-08-27
excerpt: "hairpin NAT(NATループバック)について"
config: true
tag: ["hairpin nat", "NATループバック", "ヘアピンNAT"]
comments: false
sort_key: "2022-08-27"
update_dates: ["2022-08-27"]
---

# hairpin NAT(NATループバック)について

## 概要
 - イントラネットから自身のGlobal IPを参照しようとしたとき、NATマスカレードで自身をちゃんと参照する機能
 - ルータの機能の一部で、搭載している機種は多くない
   - Yamaha, Ciscoなどがサポートしている
 - プロバイダによってはヘアピンNATのようなことを透過的にサポートしていることがある
   - IIJなど

## ヘアピンNATができない場合のワークアラウンド
 - 具体的な手段
   - DNSを編集する
   - クラウドにステップサーバを用意する
   - ２つ以上の回線を利用する
   - ヘアピンNATをサポートするルータに変更する 
   - 諦めて、localとglobalで別のホスト名を利用する

## 参考
 - [ヘアピン NAT 機能/Yamaha](http://www.rtpro.yamaha.co.jp/RT/docs/nat-descriptor/hairpin_nat.html)
 - [Cisco ASA でヘアピン NAT を設定する](https://sig9.org/archives/4020)
