---
layout: post
title: "apple notes"
date: 2022-09-19
excerpt: "apple notes(メモ)の使い方"
tags: ["apple", "notes", "メモ", "iOS", "macOS"]
config: true
comments: false
sort_key: "2022-09-19"
update_dates: ["2022-09-19"]
---

# apple notes(メモ)の使い方

## 概要
 - iosやmacOSでデフォルトでインストールされているメモアプリ
 - 日本語では`メモ`, 英語では`notes`で命名が異なる
 - iCloudで内容が同期されており、iPhoneで編集した内容をMacBookで確認することができる
   - iPhoneでドラフトを作成し、MacBookで清書するような使い方を行える
 - フォルダ構造を持つことができるが、ファイル名は存在しない
   - ファイル名は最初に入力した数行が要約されて使用される
 - `spotlight`で検索できる
 
## 検索
 - macOS
   - 右上の`Search`のフィールドに言語を入力して検索できる
 - iOS
   - `notes`アプリから、プルダウンして`検索`フィールドを出現させて、検索
   - `ホーム画面をプルダウン` or `検索`を押して、spotlightを起動して、検索
 - 制約
   - **フォルダ名でマッチすることはできない**ので、検索で確認が必要な資料には、テキストオブジェクトにその内容を記す必要がある

## フォーマット
 - 選べるフォーマット
   - Bold
   - Italic
   - Underbar
   - Title
   - Heading
   - Subheading
   - Body
   - Monospace
   - Bulleted List
   - Dashed List
   - Numbered List
 - 組み込めるオブジェクト
   - Table(表)
   - Photo

## ピン留め
 - 概要
   - フォルダの上部にテキストオブジェクトを固定するフラグ
 - やり方
   - macOS
     - テキストオブジェクトを右クリックして`Pin Note`を選択
   - ios
     - テキストオブジェクトを長押しして`メモをピンで固定`を選択

## ロック
 - 概要
   - テキストオブジェクトにパスワードをかける機能

## タグ
 - 概要
   - テキストオブジェクトにタグを付ける機能
   - `#`を単語の前につけると、タグとして認識される

## トラブルシューティング

### iOSでメモが検索できない
 - 原因
   - キャッシュかインデックスが更新されていないなどの問題がある
 - 対応
   - `設定` > `メモ` > `このAppから学習`をオフにして再起動 > `このAppから学習`をオンにする
 - 参考
   - [iPhoneメモアプリの検索機能で検索できない見つからない時の対処法](https://monew.jp/iphone-memo-search-doesnt-work/)
