---
layout: post
title: "jump desktop"
date: 2022-02-22
excerpt: "jump desktopの使い方"
project: false
config: true
tag: ["remote desktop", "jump desktop", "rdp"]
comments: false
sort_key: "2022-02-23"
update_dates: ["2022-02-23","2022-02-22","2022-02-22"]
---

# jump desktopの使い方

## 概要
 - remote desktopの一つ
   - rdpとは異なるfluidプロトコルというもので接続するので、rdpがバグったときなどの代替としても役に立つ
   - iosのrdpからctrl + ]などの独自ショートカットが動作しないがjump desktopでは動作する
 - ipadからwindows, macなどのデスクトップに接続するソフトウェアとしてredditで評価が高い
 - SSOに対応しており、applt id, google accountで認証できる

---

## クライアントソフトウェア
 - 各クライアントソフトウェア
   - [ios](https://apps.apple.com/us/app/jump-desktop-remote-desktop/id364876095)
   - [android](https://play.google.com/store/apps/details?id=com.p5sys.android.jump)

### 操作方法
 - ログイン後に画面中央のハンバーガーボタンを押すとメニューが表示される

### 設定
 - `ジェスチャープロフィール`
   - `画面をロックしました`を選択
   - apple pencileに特化した操作を行いたい場合は`ペン`を選択

### トラブルシューティング
 - 日本語入力しかできない、キーを押すと謎の挙動が発生する
   - ipadのIMEが日本語から始めると発生する
   - 一度、セッションを切断してipadを英語にして再接続することで解決する

---

## サーバサイドソフトウェア
 - サーバサイドソフトウェア
   - [Install Jump Desktop Connect](https://jumpdesktop.com/connect/)


