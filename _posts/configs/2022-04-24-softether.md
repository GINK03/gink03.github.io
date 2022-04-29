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
   - PacketiXをインストールしてしまうと体験版になってしまうのでインストールしない
 - [vpngate.net](https://www.vpngate.net/ja/)という実験ネットワークが公開されており、だれでも参加できる
   - 国内のノードが多く、他の公開リストのネットワークに比べて安定している
 - VPNのプロトコルは`SSL-VPN`, `L2TP SoftEther`という規格
 - サーバ、クライアントともにWindowsと相性がいい

---

## クライアントの設定

### 公開ネットワークのアクセスアドオンを含んだVPNクライアント
 - [VPN Gate Client download (for Windows, freeware)](https://www.vpngate.net/en/download.aspx)

### MacOSでの接続方法
 - mac osのクライアントはない 
   - L2TP over IPsecのVPNとsoftetherのデフォルトのVPNのプロトコルは異なるらしく、設定のハードルが高い
     - softetherのポートとは別に、UDP 500, 1194, 4500が適切にサーバーのマシンにマップされている必要がある
   - mac, iphoneではL2TP over IPsecでアクセスすることが推奨されている
     - osxでの接続の手順
       - VPNを新規作成
       - L2TP over IPsecを選択
       - サーバアドレスはIPアドレスやホスト名を利用
       - アカウント名は {VirtualHUB-name}/{ユーザ名}
       - パスワードはユーザパスワード
       - 共有シークレットはIPsec preshared keyを入力する
       - ネットワークオプションから、すべてのトラフィックをVPN経由で送信、とするとネットワークを暗号化できる
   - 参考
     - [MacBook Pro から SoftEther VPN サーバーに VPN 接続する方法](https://www.gadgets-today.net/?p=6072)
     - [Softether VPN serverをGUIで初期設定する][https://qiita.com/honahuku/items/5a29355faaf363f87654]
     - [VPNサーバ構築(7) SoftEther VPNのインストール](https://zenn.dev/kumatani/articles/vpn-7-installingsoftethervpn)

---

## サーバの設定

### サーバの新規作成
 1. softether vpnサーバー管理マネージャを起動
 2. 新しい接続設定
 3. localhostだけ選択し、何も入力しないまま進める
 4. 接続するとパスワード設定を求められることがあり、その場合設定
 5. 仮想HUBを管理
   1. ユーザを追加削除
   2. L2TP/IPsecの設定をしないとios, osxからは利用できないのでする
     - L2TP/IPsecを有効にする
     - IPsec preshared keyはここで設定する

---

## サードパーティが提供するSoftether Clientが使えるVPNサーバ

### [VPNJANTIT](https://www.vpnjantit.com/free-softether-l2tp-india) 
 - インドのVPNサーバ
 - ポイントを買って数時間のアクセス権を得ることができる
 - 数時間だけVPNを使用したいときに便利

## サイトのアクセス国の判定ロジック
 - `IPv6の示す地域名 > IPv4の示す地域名`である

## 参考
 - [Youtubeプレミアムを安くする方法は違法【インドVPN】](https://kikankou.co.jp/vpn/youtube-premium-vpn-india/)
   - 法律ではないが、規約で禁止されており、特定のサービスをVPNを介して利用することで損害を与えてはならない
