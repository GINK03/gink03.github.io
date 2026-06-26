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
update_dates: ["2022-05-07", "2026-06-16"]
---

## 概要
 - [always free](https://www.oracle.com/jp/cloud/free/)という期間無制限で無料の枠がある
   - サービスごとの上限は変わることがあるため、作成前に[Always Free Resources](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm)と`Limits, Quotas and Usage`を確認する
   - ARM CPU
     - VM.Standard.A1.Flexで月1,500 OCPU時間、9,000GB時間まで
     - Always Freeテナンシでは合計2 OCPU、12GBメモリ相当
     - 1台にまとめるか、1 OCPUのVMを2台まで作れる
     - Home regionでのみAlways Freeとして作成できる
   - AMD CPU
     - VM.Standard.E2.1.Microを2台まで
     - 1/8 OCPUと1GBメモリまで
     - 複数ADがあるリージョンでも作成できるADが限定される
   - ブロックボリューム
     - ブートボリュームとBlock Volumeの合計200GBまで
     - Compute作成時のブートボリュームも200GBの枠を消費する
     - Always Freeのボリュームバックアップは5個まで
     - Home region以外で作成すると課金される
   - オブジェクトストレージ
     - Always FreeのみのアカウントではStandard、Infrequent Access、Archiveの合計20GBまで
     - Object Storage APIリクエストは月50,000まで
   - ネットワーク
     - Free TierテナンシのVCNは2個まで
     - アウトバウンドデータ転送は月10TBまで
     - すべてのComputeにpublic IPv4を割り当てる必要はない

## VCNのfirewallの設定
 - `仮想クラウド・ネットワーク`を選択
 - `(自動で)作成されたvcn`の選択
 - `セキュリティ・リストの詳細`を選択
 - `イングレスルールの追加`を選択(sshの設定)
   - `0.0.0.0/0`からのTCPのソースAllと宛先ポート22を許可
   - `::/0`からのTCP, UDP, ICMPのソースAllと宛先ポート22を許可

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
 - [Oracle CloudのAlways FreeのArmは空いていないからAMDにしよう](https://blog.usuyuki.net/oracle_cloud_always_free/)
 - [Oracle Cloud で Compute にWebサーバーを立てたメモ](https://zenn.dev/yakumo/articles/883fb3017c18417d9668c0aced5dd82c)
 - [Oracle Cloud Infrastructure（OCI）とは？メリットや成功事例を紹介！](https://products.sint.co.jp/siob/blog/oracle-cloud-infrastructure)
 - [Oracle Linux 8でWordPressサーバを立てる](https://blog.osakana.net/archives/11232)

---

## トラブルシューティング

### ブロックボリュームで課金が発生する
 - 原因
   - Home region以外でブロックボリュームを作成するとチャージされる
   - ブートボリュームとBlock Volumeの合計200GBを超えると課金対象になる
   - カナダのモントリオールをHome regionにしてしまうと、東京でインスタンスを作成するとブートボリュームに対してどうしても課金が発生する
 - 参考
   - [Being charged for free Block Volumes/Reddit](https://www.reddit.com/r/oraclecloud/comments/og0dsb/being_charged_for_free_block_volumes/)

## 参考
 - [Oracle Cloud Infrastructure Free Tier](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier.htm)
 - [Always Free Resources](https://docs.oracle.com/en-us/iaas/Content/FreeTier/freetier_topic-Always_Free_Resources.htm)
 - [ずっと無料で使えるクラウドの「Free Tier」主要サービスまとめ　2021年版](https://www.itmedia.co.jp/news/articles/2106/21/news143_2.html)
 - [Oracle Cloudですでに作成済みのネットワークに対してIPv6を有効にする方法](https://blog.osakana.net/archives/11139)
