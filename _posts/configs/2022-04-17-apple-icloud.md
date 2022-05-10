---
layout: post
title: "apple icloud"
date: 2021-04-17
excerpt: "apple icloudについて"
tags: ["apple", "ios", "osx", "support", "icloud"]
config: true
comments: false
---

# apple icloudについて

## 概要
 - Apple社が提供するクラウドサービス
 - GoogleやMSのものに比べてバグが多い印象

## iCloud Drive
 - 概要
   - クラウドドライブ
   - クライアントがosx, ios, windowsで用意されているが、Linuxはない
 - osxでの利用
   - osxでのパス
     - `~/Library/Mobile Documents`
     - このパス以下にアプリごとの固有名が作成される
   - osxのデスクトップやドキュメントで同期されるファイルのパス　
     - `~/Library/Mobile\ Documents/com~apple~CloudDocs/`
 - Windowsでの利用
   - Windowsでのパス
     - `C:/Users/<username>/iCloudDrive`
     - パスの変更はできない(windowsのシンボリックリンクを利用してソフトウェアを騙すことは可能)
   - インストール直後は大量のダウンロードが発生するため、数時間経たないと新規ファイル等のアップロード等の操作は行えない
 - webクライアント
   - [www.icloud.com/iclouddrive/](https://www.icloud.com/iclouddrive/)

## iCloud メール
 - 概要
   - かっこいいメールアドレスが取得できる可能性が高いが、メールフィルタがgmailほど賢くない
   - gmailに全転送して使うのが現実的

## 参考
 - [mac iCloudフォルダパス| ターミナルコマンドでiCloudファイルへ移動する方法](https://qiita.com/thinkalot/items/246ec53804d907950e23)
