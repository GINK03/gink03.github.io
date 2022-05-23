---
layout: post
title: "coteditor"
date: 2022-04-17
excerpt: "coteditorの使い方"
project: false
config: true
tag: ["osx", "text editor", "coteditor"]
comments: false
sort_key: "2022-04-21"
update_dates: ["2022-04-21","2022-04-17"]
---

# coteditorの使い方

## 概要
 - osxで使える軽量なテキストエディタ
   - 残念ながらios版は無い
 - 軽く動作のレスポンスが良いのでチャットの下書きや議事録に便利
 - iCloud経由で同期&バックアップする機能があり、iPhoneや別のmacで確認できる

## インストール
 - brewかappstoreを利用する

```console
$ brew install coteditor
```

## おすすめな設定
 - 常にタブで開く
   - `設定` -> `ウィンドウ` -> `タブを優先` -> `常に`
 - 入力補完を有効にする
   - `設定` -> `編集` -> `入力中に補完候補を表示`

## 基本的な操作
 - シンタックスハイライトの適応
   - `フォーマット` -> `シンタックススタイル` -> なにかフォーマットを選ぶ
 - インデントの一括変更
   - 右へインデント
     - 範囲を選択 -> `⌘ + ]`
   - 左へインデント
     - 範囲を選択 -> `⌘ + [`

## 参考
 - [「CotEditor タブで開く」が使える！](https://web-preparation.com/coteditor-tab/)
 - [【CotEditor】テキストエディタの使い方を解説！Mac OSにオススメできる理由とは？競合エディタとの違いも紹介](https://agency-star.co.jp/column/coteditor)


