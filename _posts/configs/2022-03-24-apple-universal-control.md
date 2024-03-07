---
layout: post
title: "apple universal control"
date: 2022-03-24
excerpt: "appleのuniversal control(ユニバーサルコントロール)の使い方"
config: true
tag: ["apple", "ios", "macos", "osx", "universal control"]
comments: false
sort_key: "2022-05-02"
update_dates: ["2022-05-02","2022-03-28","2022-03-26","2022-03-25","2022-03-24"]
---

# appleのuniversal control(ユニバーサルコントロール)の使い方

## 概要
 - MacBookとiPadのキーボードとマウスを一体化してシームレスに移動・コントロールする仕組み
 - 簡単なファイルのやり取りをD&Dで行える
 - sidecarやduetなどは遅延が発生するが、キーボードとマウスの移動だけが発生するので軽く、それぞれのデバイスのリソースをフルに使える
 - macOS sonoma(14.0)以降 + jamfで管理されているデバイスでは、動作しない

## 必要要件
 - 最新のipad os, osx
 - それぞれのデバイスでWiFi, Bluetooth, Handoffが有効になっていること
   - WiFiでで接続する場合、同じサブネットマスクにある必要がある
   - テザリング環境下など通信がうまくできない環境ではUSB接続で通信できる
 - 同じapple idでログインしていること
 - `[システム環境設定]` -> `[ディスプレイ]` -> `[ユニバーサルコントロール]`

## 基本的な使い方
 - iPadからホームに戻る
   - 下のバーをクリック
 - アプリの切り替え
   - MacBookのディスプレイ切り替えと同じタッチパッドのスワイプ
 - コピーアンドペースト
   - できないのでドラッグアンドドロップする

## 手動でユニバーサルコントロールを開始する
 - 自動で開始されてないことがあり、以下の手順を踏むと開始されることがある
 - `[システム環境設定]` -> `[ディスプレイ]` -> (キーボードとマウスをリンク)から`[ディスプレイを追加]`のデバイスを選択

## トラブルシューティング
 - iPadへカーソルが行ったまま帰ってこない
   - 通信が不安定になっていることが原因
   - 一度MacBookを閉じて再度開くと直る
 - WiFi経由でユニバーサルコントロールを行った時マウスが遅延する
   - USBで接続し直すと改善する
 - USB接続でテザリング時にユニバーサルコントロールが開始されない
   - WiFiのイベントと紐付いているらしく、WiFiがONになっている必要がある
 - Bluetooth接続しているときにマウスやキーボードが遅延する
   - iPadを再起動すると改善する

## 参考
 - [「ユニバーサルコントロール」を利用する方法](https://applech2.com/archives/20220315-how-to-use-universal-control-macos-123-monterey.html)
 - [Mac ユニバーサルコントロールの使い方と、アップデート方法と、使用感](https://youtu.be/kc71EfsEo5w)

## トラブルシューティング
 - sonoma(14.0) + jamfで管理されているデバイスで動作しない
   - 原因
     - jamfが導入されている場合、ユーザのAppleIDがプライマリのAppleIDではないので、ユニバーサルコントロールが動作しない
   - 参考
     - [Jamf + Apple's Universal Control](https://community.jamf.com/t5/jamf-pro/jamf-apple-s-universal-control/td-p/291922)
 - 前回動作したのに動作しなくなった
   - 原因
     - 不明
   - 対応
     - `システム環境設定` -> `ディスプレイ` -> `ユニバーサルコントロール` -> `Allow your pointer and keyboard ...`をOFFにして、再度ONにすると動作する
