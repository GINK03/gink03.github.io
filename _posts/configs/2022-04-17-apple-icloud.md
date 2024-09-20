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
 - GoogleやMSのものに比べてバグが多い印象
 - iCloud DriveはmacOSでは深い箇所にpathが設定されているのでシンボリックリンクを貼っておいたほうが利便性が高い

## iCloud Drive(ソフトウェア)
 - 概要
   - クラウドドライブソフトウェア
   - appleのデバイスではデフォルトで入っている
   - クライアントがmacOS, ios, windowsで用意されているが、Linuxはない
 - macOSでの利用
   - macOSでのパス
     - `~/Library/Mobile Documents`
     - このパス以下にアプリごとの固有名が作成される
   - macOSのデスクトップやドキュメントで同期されるファイルのパス　
     - `~/Library/Mobile\ Documents/com~apple~CloudDocs/`
 - Windowsでの利用
   - Windowsでのパス
     - `C:/Users/<username>/iCloudDrive`
     - パスの変更はできない(windowsのシンボリックリンクを利用してソフトウェアを騙すことは可能)
   - インストール直後は大量のダウンロードが発生するため、数時間経たないと新規ファイル等のアップロード等の操作は行えない
 - webクライアント
   - [www.icloud.com/iclouddrive/](https://www.icloud.com/iclouddrive/)
 - トラブルシューティング
   - ファイルの同期が遅くファイルの削除が反映されない場合
     - Webクライアントでファイルを削除するとすべてのデバイスでファイルが削除される
   - 容量を食いつぶしてしまう
     - DesktopやDocumentsにファイルを置いていると同期されるため、大容量のファイルを置かないようにする

## iCloud メール
 - 概要
   - かっこいいメールアドレスが取得できる可能性が高いが、メールフィルタがgmailほど賢くない
   - gmailに全転送して使うのが現実的

## iCloud リンク
 - 概要
   - 30日間有効なアクセスリンクを提供する
   - AirDropが使えないときの代替手段として使える
 - 使用法
   - `共有ボタン`を選択
   - `iCloud リンクをコピー`を選択
   - リンクアドレスをe-mailなどで共有

## 参考
 - [mac iCloudフォルダパス| ターミナルコマンドでiCloudファイルへ移動する方法/qiita](https://qiita.com/thinkalot/items/246ec53804d907950e23)
 - [iCloud.comでiCloudのリンクを使って写真とビデオを共有する/support.apple.com](https://support.apple.com/ja-jp/guide/icloud/mm93a9b98683/icloud)
