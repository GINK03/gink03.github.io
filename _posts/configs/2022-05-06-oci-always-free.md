---
layout: post
title: "OCI Always Free"
date: 2022-05-03
excerpt: "OCI Always Freeについて"
project: false
config: true
tag: ["oci", "oracle", "oracle cloud infrastructure", "cloud"]
comments: false
sort_key: "2022-05-07"
update_dates: ["2022-05-07"]
---

# OCI Always Freeについて

## 概要
 - [always free](https://www.oracle.com/jp/cloud/free/)という期間無制限で無料の枠がある
   - ARM CPU
     - Arm Ampere A1 Computeで4コア、24GBメモリを一台まで
     - 2つのBlock Storageで合計200GBまで
     - 初期に選択したリージョンしか無料枠では利用できない
   - AMD CPU
     - 2つのVMまで
     - 1/8OCPUと1GBのメモリーまで
   - ブロックボリューム
     - 2つで合計200GBまで

## VCNのfirewallの設定
 - `仮想クラウド・ネットワーク`を選択
 - `(自動で)作成されたvcn`の選択
 - `セキュリティ・リストの詳細`を選択
 - `イングレスルールの追加`を選択
   - `0.0.0.0/0`からのTCP, UDP, ICMPのAllを許可
   - `::/0`からのTCP, UDP, ICMPのAllを許可

## IPv6の有効化
 - 仮想クラウド・ネットワーク
   - `CIDR Blocks/Prefixes`から`Add CIDR Block/IPv6 Prefix`を選択
   - `Subnets`から`IPv6 Prefix`を設定(任意の00 - FFの値にできる)
 - コンピュートにIPv6を割り当て
   - `コンピュート` -> `インスタンス` -> `インスタンスの詳細` -> `アタッチされたVNIC` -> `VNICの詳細` -> `IPv6アドレス`
   - 手動でipv6の値を割り当てる
   - インスタンス上でipv6を取得
     - `sudo dhclient -6`
   - 例えば、ubuntuだと、iptablesでfirewallが構成されているので無効化する

## 無料枠で使用する際に参考になるサイト
 - [Oracle CloudのAlways FreeのArmは空いていないからAMDにしよう。](https://blog.usuyuki.net/oracle_cloud_always_free/)
 - [Oracle Cloud で Compute にWebサーバーを立てたメモ](https://zenn.dev/yakumo/articles/883fb3017c18417d9668c0aced5dd82c)
 - [Oracle Cloud Infrastructure（OCI）とは？メリットや成功事例を紹介！](https://products.sint.co.jp/siob/blog/oracle-cloud-infrastructure)
 - [Oracle Linux 8でWordPressサーバを立てる](https://blog.osakana.net/archives/11232)


## 参考
 - [ずっと無料で使えるクラウドの「Free Tier」主要サービスまとめ　2021年版](https://www.itmedia.co.jp/news/articles/2106/21/news143_2.html)
 - [Oracle Cloudですでに作成済みのネットワークに対してIPv6を有効にする方法](https://blog.osakana.net/archives/11139)
