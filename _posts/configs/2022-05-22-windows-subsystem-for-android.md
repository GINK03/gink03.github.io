---
layout: post
title: "WSA(Windows Subsystem for Android)"
date: "2022-05-22"
excerpt: "WSL(Windows Subsystem for Android)の使い方"
project: false
config: true
tag: ["windows", "android", "wsa", "Windows Subsystem for Android"]
comments: false
sort_key: "2022-05-22"
update_dates: ["2022-05-22"]
---

# WSA(Windows Subsystem for Android)の使い方

## 概要
 - Windows 11上でAndroidのアプリを使用可能にする機能
 - WSLと同様の仕組み

## インストール
 - 手順
   - `windows 11`の地域の設定を米国にする
   - `microsoft store`を起動して`amazon appstor`eをインストール
     - このときに`windows subsystem for android`がアプリとしてインストールされているはずである
   - `windows subsystem for android`のアプリを起動する
     - 開発者モードを有効化する
     - `adb connect 127.0.0.1:58526`で仮想デバイスに接続
     - `adb install <any-package.apk>`で任意のアプリをsideloadできる
       - [/aurora-store/](/aurora-store/)を入れると殆どのアプリを使用可能になる 
       - 多くのアプリは動くが、google mapなど動かないものもある
 - トラブルシューティング
   - `adb connect`できない
     - 対応
       - 再起動すると直る

## 参考
 - [Windows Subsystem for Android/Microsoft Build](https://docs.microsoft.com/en-us/windows/android/wsa/)
