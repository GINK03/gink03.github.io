---
layout: post
title: "Apple MacBook"
date: 2022-07-18
excerpt: "Apple MacBookについて"
tags: ["apple", "macos", "osx"]
config: true
comments: false
sort_key: "2022-07-18"
update_dates: ["2022-07-18"]
---


# Apple MacBookについて

## 概要
 - Apple社のmacOSを搭載したノートパソコン
 - 世界中でたくさんの台数が製造・出荷されるので替わりが効きやすく、多数のユーザによりフィードバックがあるためハードウェア・ソフトウェアのUI/UXが優れている
 - CPUにはamd64とarmがある

## クラムシェルモードでの利用
 - **ユースケース**
   - 古いMacBookをメディアプレイヤー兼メディアサーバとしてクラムシェルモードでTVにつなぐ
 - **必要なもの**
   - クラムシェルスタンド
     - 横置きよりスペースが小さく、誤って踏みつけてしまうリスクからも保護できる
   - Bluetoothで利用できるキーボードとマウス
     - Magic Keyboard
     - Magic Mouse
   - 外部ディスプレイの接続方法の確保
     - Thunderbold 3, 4
     - HDMI出力可能なハブ
 - **MacBook側の設定**
   - sshdを設定しておく
   - スリープをしないようにする

## アクセサリ

### スリーブ
 - 概要
   - そのままmacbookをかばんに入れると壊れるリスクがあるのでスリーブに入れたほうがいい
   - タイベックという軽い不織布のスリーブが軽くてよい
 - 製品
   - [ダルトン/パデッド エンベロープ](https://www.dulton.jp/onlineshop/g/gY925-1247TB/)

## トラブルシューティング

### HDMI出力可能なハブ経由でTVに出力するとちらつく, 60Hzで出力できない
 - 原因
   - HDMIハブの問題で、品質が一定しなく、正常に出力できない
 - 対応
   - Thunderboldのケーブルで繋ぐ
