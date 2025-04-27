---
layout: post
title: "microsoft edge"
date: 2023-02-18
excerpt: "microsoft edgeについて"
project: false
config: true
tag: ["microsoft", "マイクロソフト", "edge", "ブラウザ"]
comments: false
sort_key: "2023-02-18"
update_dates: ["2023-02-18"]
---

# microsoft edgeについて

## 概要
 - マイクロソフトが作成したブラウザ
 - google chromeと同じ描画エンジンを利用している

## ios版microsoft edge
 - 概要
   - MicrosoftのEdgeのアイコンのブラウザ
   - 描画エンジンはsafariと共通
   - 他のデバイスのedgeと今見ているページを共有する事ができる
   - 広告をブロックすることができる
   - ページの翻訳を行うことができる
 - 広告をブロック
   - `設定` -> `プライバシーとセキュリティ` -> `広告をブロックする` + `ポップアップをブロックする`
 - ページの翻訳
   - `設定` -> `全般` -> `Microsoft 翻訳ツール` -> `ページの翻訳`を有効化する
 - 致命的な仕様・バグ
   - edgeがクラッシュすると開いていたタブの復旧ができない
     - 参照していたページの情報が失われる

## macOS版microsoft edge
 - 概要
   - iosなどの他のデバイスで開いていたedgeのタブを`履歴`->`タブ`で確認できる
     - 作業を連続して継続できる
 - インストール
   - `brew install --cask microsoft-edge`

## 設定

### Optimize Performance
 - `Save resources with sleeping tabs` でメモリを節約することができる
 - `Put inactive tabs to sleep after the specified amount of time:` でスリープするまでの時間を指定できる
