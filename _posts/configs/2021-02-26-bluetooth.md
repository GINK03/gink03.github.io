---
layout: post
title: "bluetooth"
date: 2021-02-26
excerpt: "bluetoothの規格"
tags: ["bluetooth"]
config: true
comments: false
sort_key: "2021-02-26"
update_dates: ["2021-02-26"]
---

# bluetoothの規格

bluetoothでイヤホンを接続するにあたり適切な規格を選択しないと音声が途切れたり通信が不安定になったりする  

## windows 10とワイヤレスイヤホンの接続の問題
class 2でversion 5.0のBluetoothで接続したところ接続が数秒に一回途切れ使用できない  
原因は出力不足であった  

class 1のversion 4.0のbluetoothしたところ安定して通信することができた  

## class
 - class 1
   - 100mW
   - 半径100mまで
 - class 2
   - 2.5mW
   - 半径10mまで

## 購入した製品
 - [LBT-UAN05C1](https://www.elecom.co.jp/products/LBT-UAN05C1.html)
   - class 1
   - 安定して使える
 - [UB400](https://www.tp-link.com/uk/home-networking/adapter/ub400/)
   - class 2
   - 1mの距離でも途切れて使用できなかった
