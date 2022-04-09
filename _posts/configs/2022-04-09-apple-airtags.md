---
layout: post
title: "Apple AirTags"
date: 2022-04-09
excerpt: "Apple AirTagsについて"
tags: ["apple", "airtags"]
config: true
comments: false
---


# Apple AirTagsについて

## 概要
 - bluetoothとメッシュネットワークで持ち物の場所を特定することができるデバイス
 - UWBという電場を利用して方角や正確な距離がわかる
   - UWBに対応しているのはiPhone 12以降

## 留意点
 - 正常に動作するには探す対象airtagの近くにapple deviceを持っている人が必要(日本ではあまり心配ない)
 - 一部のデバイスではUWBを対応していなく、大雑把な位置特定になる(数十メートル)

## `手元から離れたときに通知`について
 - `探す`アプリから対象のAirTagの設定に行き、`手元から離れたときに通知`をオンにする
 - 自宅などを例外設定を行うことも可能

## NFC(Near field communication)タグとしての機能
 - iPhoneやAndroidでNFCタグとして読み取ることができる
   - 読み取った際に[/shortcuts/](/shortcuts/)でイベントを起こすこともできる
 - カードキーで開けるタイプの扉のキーとして設定できる
   - SUICAや白いNFCカードなどを持たなくて済む

## バッテリーの交換
 - `CR2032 3V`の電池で動作する
   - ダイソーなどで販売している
 - airtagsの金属部分を反時計回りに回転するとカバーを外すことができる
   - [AirTag の電池を交換する方法](https://support.apple.com/ja-jp/HT211670)
