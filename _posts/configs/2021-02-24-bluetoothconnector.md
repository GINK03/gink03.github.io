---
layout: post
title: "bluetoothconnector"
date: 2021-02-24
excerpt: "bluetoothconnectorの使い方"
tags: ["osx", "bluetooth"]
config: true
comments: false
---

# bluetoothconnectorの使い方

## 概要
bluetoothconnectorはbluetoothへの接続をコマンドで行えるものである  

bluetoothにはmacアドレスが付与されており、macアドレスを引数に接続できる  

## インストール
```console
$ brew install BluetoothConnector
```

## 公式サイト
 - [github](https://github.com/lapfelix/BluetoothConnector)

## 使い方

***接続可能なbluetoothの機器のmacアドレスを確認***
```console
$ BluetoothConnector
Error:
MAC Address missing. Get the MAC address from the list below (if your device is missing, pair it with your computer first):
38-ec-0d-c0-66-16 - 銀兵’s AirPods Pro
f0-c3-71-07-b6-53 - iPhone 11 Pro Max
30-d9-d9-93-05-d8 - 小林銀兵のマウス
70-f0-87-41-07-ad - Magic Keyboard
98-52-3d-77-d8-ce - Soundcore Liberty Air 2-L
98-52-3d-79-09-4a - Soundcore Liberty Air 2
00-7d-60-d4-52-b4 - 小林銀兵’s Apple Watch
8c-85-90-99-b3-fe - 小林銀兵のMacBook Pro
b8-f1-2a-e9-5e-68 - 銀兵のAirPods
38-53-9c-b2-91-5d - iPhone Xs Max
```

***特定のmacアドレスに接続***
```console
$ BluetoothConnector -c 38-ec-0d-c0-66-16
```

## 便利な使い方

karabinerの任意のショートカットを割り当てられる機能にbluetoothに接続後、デバイスを切り替えて有効にするコマンドをマッピングしている  
(別途brewでSwitchAudioSourceをインストールする必要がある)  
```console
bash -c "/opt/homebrew/bin/BluetoothConnector --connect 38-ec-0d-c0-66-16; /opt/homebrew/bin/SwitchAudioSource -s \"銀兵’s AirPods Pro\"; say \"スイッチ\""
```
