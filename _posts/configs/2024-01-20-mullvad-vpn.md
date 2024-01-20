---
layout: post
title: "mullvad vpn"
date: 2024-01-20
excerpt: "mullvad vpnの使い方"
tags: ["vpn", "mullvad", "wireguard"]
config: true
comments: false
sort_key: "2024-01-20"
update_dates: ["2024-01-20"]
---

# mullvad vpnの使い方

## 概要
 - No Log VPNの一つ
 - WireGuardを使っている
 - 月額5ユーロ(ビットコインやVプリカで支払い可能)
 - 5台まで同時接続可能
 - パスワードの概念がなく、衝突確率が低い16桁の数字のアカウント番号でログインする
 - LinuxではVPNに接続するとデフォルトでローカルネットのルーティングが変更されるので注意

## インストール

**debian**
```console
$ wget https://mullvad.net/en/download/app/deb/latest -O mullvad.deb
$ sudo dpkg -i mullvad.deb
```

## 基本的な使い方(CLI)
 - ログイン
   - `mullvad account login 1234123412341234` - アカウント番号でログイン
   - `mullvad account get` - アカウント情報を表示　
   - `mullvad account list-devices` - 登録しているデバイスを表示
 - リレーの設定
   - `mullvad relay list` - リレーの一覧を表示
   - `mullvad relay set location jp-osa-wg-001` - リレーを設定(例では大阪のリレーを設定)
 - IPルーティング
   - `mullvad lan set allow` - ローカルネットワークへのルーティングを許可
   - `mullvad dns set custom 1.1.1.1` - DNSサーバを設定
 - 接続
   - `mullvad connect` - 接続
   - `mullvad disconnect` - 切断
   - `mullvad status` - 接続状態を表示

## 参考
 - [How to use the Mullvad CLI](https://mullvad.net/en/help/how-use-mullvad-cli)
 - [Split tunneling with Linux (advanced)](https://mullvad.net/en/help/split-tunneling-with-linux-advanced)
