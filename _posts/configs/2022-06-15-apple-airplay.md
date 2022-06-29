---
layout: post
title: "Apple AirPlay"
date: 2022-06-15
excerpt: "Apple AirPlayについて"
tags: ["apple", "ios", "osx", "support", "airplay"]
config: true
comments: false
sort_key: "2022-06-15"
update_dates: ["2022-06-15"]
---


# Apple AirPlayについて

## 概要
 - Appleデバイスから他のAppleデバイスへ、P2PまたはWiFiネットワーク経由で動作する画面シェアリング機能
 - P2Pで動作させる場合、同じWiFiネットワークにある必要がないので便利
 - プロトコルはbluetoothとWiFi
 - windows, linuxのAirPlay Serverも一応ある

## 使い方
 - ミラーリング
   - iosデバイスのコントロールパネルから `ウィンドウが2枚重なったアイコン` をクリックして任意のデバイスに音声と映像を転送する
 - 音と映像の転送
   - iosデバイスのコントロールパネルから `AirPlayのアイコン` を選択し任意のデバイスに音声と映像を転送する

## トラブルシューティング
 - 映像が乱れる・音声が途切れる
   - 原因
     - 通信不良・クライアント側のAirPlayの不良
   - 対応
     - クライアントデバイスの再起動
 - AirPlayの有効化・無効化でアプリが正常な挙動をしなくなる
   - 原因
     - アプリのバグ
   - 対応
     - アプリの再起動
 - AirPlayでYouTubeの動画をストリーミングするとボリュームの調整ができない
   - 原因
     - 昔からある仕様・バグ
   - 対応
     - アプリのアップデートを期待するしかなく、何もできない
   - 対応
     - [Volume control with AirPlay/Reddit](https://www.reddit.com/r/appletv/comments/gwfjgg/volume_control_with_airplay/)

## 参考
 - [AirPlay icons](https://developer.apple.com/design/human-interface-guidelines/technologies/airplay/icons/)
 - [Airflow](https://airflow.app/)
 - [Best program for airplay from windows computer?](https://www.reddit.com/r/appletv/comments/aylidn/best_program_for_airplay_from_windows_computer/)
