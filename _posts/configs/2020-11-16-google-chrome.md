---
layout: post 
title: "chrome"
date: 2020-11-16
excerpt: "google chromeの便利な設定と機能とカスタマイズ"
project: false
config: true
tag: ["chrome", "google chrome"]
comments: false
sort_key: "2022-05-10"
update_dates: ["2022-05-10"]
---

# google chromeの便利な設定と機能とカスタマイズ 

## 便利な設定

### Google Chromeの更新後に見ていたページを復元する
 1. search barに`chrome://settings/?search=%E8%B5%B7%E5%8B%95%E6%99%82`を入力
 2. `[前回開いていたページを開く]`にチェックを入れる

### Google Chromeでsearch barを利用したカスタムショートカット(URLへのジャンプ)の登録
 1. search barから`chrome://settings/searchEngines`を開く
 2. `[追加]`から`検索エンジン`に`hoo`, `キーワード`に`hoo`, `URL`に`https://bar.com`を登録する  

以上を実行すると、search barから`hoo`と入れると、`https://bar.com`にジャンプできる  

e.g. 
 - `ca` -> `https://calendar.google.com/calendar/u/0/r`
 - `ca1` -> `https://calendar.google.com/calendar/u/1/r`
 - `re` -> `https://www.reddit.com/`
 - `ke` -> `https://keep.google.com/u/0/`
 - `pa` -> `https://paper.dropbox.com/?_tk=dropbox_web_logged_out_landing_page&role=personal`
 - `todo` -> `https://paper.dropbox.com/doc/TODOS--BAodfU5iJHWF6rSpOskQYOLrAg-7EjfRwhxsg2dSa3AgPz3b`
 - `ne` -> `https://www.netflix.com/browse`
 - `yo` -> `https://www.youtube.com/`

## 便利な機能

### タブの固定
 - 概要
   - 固定するとchromeの起動時に表示されるようになる
   - タブを閉じるショートカットを行うと消えてしまう
 - 操作
   - `タブの上で右クリック` -> `[固定]`を選択

### タブの移動
 - `Option + Cmd + 矢印` で右左のタブへ移動

### メモリの節約(memory saver)
 - `設定` -> `memory saver`を有効化することでメモリの消費を抑えることができる
 - 強さの設定
   - Moderate：抑えめに休止
   - Balanced：推奨設定
   - Maximum：すぐに休止(個人的なオススメ)

## extensions
 - extensionsの詳細は`configs/2025-11-22-google-chrome-extentions.md`を参照
