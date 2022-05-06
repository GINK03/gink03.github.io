---
layout: post
title: "OCI Always Free"
date: 2022-05-03
excerpt: "OCI Always Freeについて"
project: false
config: true
tag: ["oci", "oracle", "oracle cloud infrastructure", "cloud"]
comments: false
---

# OCI Always Freeについて

## 概要
 - [always free](Oracle Cloud Free Tier)という期間無制限で無料の枠がある
   - Arm Ampere A1 Computeで4コア、24GBメモリを一台まで
   - 2つのBlock Storageで合計200GBまで
   - 初期に選択したリージョンしか無料枠では利用できない

## VCNのfirewallの設定
 - `仮想クラウド・ネットワーク`を選択
 - `(自動で)作成されたvcn`の選択
 - `セキュリティ・リストの詳細`を選択
 - `イングレスルールの追加`を選択
   - `0.0.0.0/0`からのTCP, UDP, ICMPのAllを許可
   - `::/0`からのTCP, UDP, ICMPのAllを許可

## 無料枠で使用する際に参考になるサイト
 - [Oracle CloudのAlways FreeのArmは空いていないからAMDにしよう。](https://blog.usuyuki.net/oracle_cloud_always_free/)
 - [Oracle Cloud で Compute にWebサーバーを立てたメモ](https://zenn.dev/yakumo/articles/883fb3017c18417d9668c0aced5dd82c)
 - [Oracle Cloud Infrastructure（OCI）とは？メリットや成功事例を紹介！](https://products.sint.co.jp/siob/blog/oracle-cloud-infrastructure)
 - [Oracle Linux 8でWordPressサーバを立てる](https://blog.osakana.net/archives/11232)
