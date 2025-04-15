---
layout: post
title: "apple iCloud"
date: 2021-04-17
excerpt: "apple iCloudについて"
tags: ["apple", "ios", "macOS", "support", "icloud"]
config: true
comments: false
sort_key: "2022-05-10"
update_dates: ["2022-05-10","2022-04-17"]
---

# apple iCloudについて

## 概要
 - Apple社が提供するクラウドサービス
 - iCloud DriveはmacOSでは深い箇所にpathが設定されているのでシンボリックリンクを貼っておいたほうが利便性が高い
 - FinderからiCloud Driveにアクセスすることができる

## iCloud Drive
 - macOSでの利用
   - macOSのデスクトップやドキュメントで同期されるファイルのパス　
     - `~/Library/Mobile\ Documents/com~apple~CloudDocs/`
   - 明示的にファイルを同期
     - iCloud Driveにファイルを置いて右クリックから`Share...`を選択する
 - webクライアント
   - [www.icloud.com/iclouddrive/](https://www.icloud.com/iclouddrive/)
 - トラブルシューティング
   - ファイルの同期が遅くファイルの削除が反映されない場合
     - Webクライアントでファイルを削除するとすべてのデバイスでファイルが削除される
   - 容量を食いつぶしてしまう
     - DesktopやDocumentsにファイルを置いていると同期されるため、大容量のファイルを置かないようにする

## iCloud メール
 - かっこいいメールアドレスが取得できる可能性が高いが、メールフィルタがgmailほど賢くない
 - gmailに全転送して使うのが現実的

## 参考
 - [mac iCloudフォルダパス| ターミナルコマンドでiCloudファイルへ移動する方法/qiita](https://qiita.com/thinkalot/items/246ec53804d907950e23)
 - [iCloud.comでiCloudのリンクを使って写真とビデオを共有する/support.apple.com](https://support.apple.com/ja-jp/guide/icloud/mm93a9b98683/icloud)
