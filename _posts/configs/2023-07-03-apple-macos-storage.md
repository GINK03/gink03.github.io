---
layout: post
title: "macOS storage"
date: 2023-07-03
excerpt: "macOSの(外付け)ストレージの管理"
tags: ["apple", "macos", "osx", "settings"]
config: true
comments: false
sort_key: "2023-07-03"
update_dates: ["2023-07-03"]
---

# apple macos storage

## 概要
 - macosのストレージは不足しがちなのでワークアラウンドで解決する

## コンテンツを外付けSSDにアプリを移動する
 -  アプリの移動
   - アプリをD&Dで移動してシンボリックリンクを作成する
     - `$ sudo ln -s /Volumes/<SSD>/<application-name> /Applications/<application-name>`
 - フォトライブラリを移動する
   - `~/Pictures/Photos Library.photoslibrary`を外付けSSDに移動
   - `Photos.app`を`option`を押しながら起動すると新たにフォトライブラリを選択できる
   - 参考
     - [フォトライブラリを移動して Mac の容量を節約する/support.apple.com](https://support.apple.com/ja-jp/HT201517)

## ストレージのベンチマーク
 - [AmorphousDiskMark](https://www.katsurashareware.com/amorphousdiskmark/)がCrystalDiskMarkというソフトウェアの使用感と出力形式に近いので確認できる

## トラブルシューティング
 - USB接続で速度が出ない
   - 原因
     - USBコントローラの相性で高速通信できていない
     - appleのハードウェアとはこの問題が起きやすいらしい
   - 対応
     - (問題がない)USBハブを経由する
     - type-cならthunderbolt認証のケーブルで接続する
