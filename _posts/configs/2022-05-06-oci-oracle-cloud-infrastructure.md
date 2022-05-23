---
layout: post
title: "OCI(oracle cloud infrastructure)"
date: 2022-05-03
excerpt: "OCI(oracle cloud infrastructure)について"
project: false
config: true
tag: ["oci", "oracle", "oracle cloud infrastructure", "cloud"]
comments: false
sort_key: "2022-05-06"
update_dates: ["2022-05-06"]
---

# OCI(oracle cloud infrastructure)について

## 概要
 - Oracleが提供するクラウドサービス
 - AWSと似たインターフェースと機能を備えている
 - コストがAWSより安いと宣伝されている
 - [always free](Oracle Cloud Free Tier)という期間無制限で無料の枠がある
   - Arm Ampere A1 Computeで4コア、24GBメモリを一台まで
   - 2つのBlock Storageで合計200GBまで

## 基本的な機能と用語の説明
 - **コンピュート**
   - AWS compute instancesと同じ
 - **ネットワーキング(VNC)**
   - AWSのVNCとほぼ同じ

## OCIでの無料枠でのUbuntu Linuxの特徴
 - iptablesベースのfirewallが設定されている
   - 参考
     - [(OCI)Ubuntuインスタンスではiptablesに気をつけたい](https://www.tericle.jp/oci-ubuntu-iptables/)
 - VNCを設定しないと任意のポート/プロトコルでは通信できない
 - ipv6はデフォルトで有効化されていない
