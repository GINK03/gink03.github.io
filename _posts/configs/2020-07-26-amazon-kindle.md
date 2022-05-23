---
layout: post
title: "Amazon Kindle"
date: 2020-07-26
excerpt: "Amazon Kindleの使い方"
project: false
config: true
tag: ["kindle", "amazon"]
comments: false
sort_key: "2022-05-10"
update_dates: ["2022-05-10"]
---

# Amazon Kindleの使い方

---

# Kindle Unlimitedの検索方法
 - 方法
   - PCで検索してiPhone(Android)で読むというプロセスが良さそう
   - 検索クエリの度にkindle unlimited対応チェックボタンを押す必要がありUIが良くない(有料の本を買ってほしいからだと考えられる)
     - 通常の検索後、左側にkindle unlimited対応のチェックを入れてウェブページが更新されるプロセスを踏む必要がある
   - 色んな人がkindle unlimited検索ツールを作っている
 - 参考
   - [アンリミで本を探すときのこつ](https://scrapbox.io/KindleUnlimited/%E3%82%A2%E3%83%B3%E3%83%AA%E3%83%9F%E3%81%A7%E6%9C%AC%E3%82%92%E6%8E%A2%E3%81%99%E3%81%A8%E3%81%8D%E3%81%AE%E3%81%93%E3%81%A4)

---

# iOS, kindle読み上げ方法
 - 読書は目が非常に疲れる、手があかなくなるなどがあり、これを解決する手段として、iOSに入っている`コンテンツの読み上げ機能`を使って、改善できる  
 - また、iOSの`Alexaアプリ`で読み上げることができる  
   - Alexaでは読み上げが不完全で、レジューム機能が機能しない　


## 設定
 1. `[Accessibility]` -> `[Spoken Content]` -> `[Speak Screen]` + `[Speech Controller + ON]`
 2. `1` を実行済みのあと、kindleアプリを立ち上げ、フローティングボタンを押し、その中の少項目の再生のボタンを押す

## ヒューリスティクス
 - 画面を消すと再生されない -> 電源をONにし続ける
 - AirPodsを外すと本体から音がする -> AirPods以外のイヤホンにすると大丈夫

## `Alexaアプリ`経由で行う場合
 - iOSに`Alexa`をインストールして、ログインする。
 - `再生`のセクションから、購入した本を選び、クリックして、`このデバイス`を選択する
 - 途中から再生する場合、`Kindleアプリ`で同期された位置から読み上げる
 - 読み上げスピードを変化させるには、`Alexaアプリ`に向かって「もっと早く読んで」と言えば良い
 - 参考
   - [*Alexaで読み上げるKindle本の同期に関する問題*](https://www.amazon.co.jp/gp/help/customer/display.html?nodeId=GDNJ68Z4KQE9VRRT)

---

# Android, kindle読み上げ

## 手順
 - kindleアプリで本一覧を表示
 - talkbackを有効にする
 - 本を選択
 - 右に一本指でスワイプしてダブルタップで通し読みが開始される
