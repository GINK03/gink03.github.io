---
layout: post 
title: "google chrome extentions"
date: 2025-11-22
excerpt: "google chromeのextensionsまとめ"
project: false
config: true
tag: ["chrome", "google chrome"]
comments: false
sort_key: "2025-11-22"
update_dates: ["2025-11-22"]
---

# google chrome extentions

## Vimium
vimライクなキーバインドをgoogle chromeに追加する  
 - キーボードでリンクのクリック候補を出してクリックできるのはこれしかない(視線でデフォルトをjとかそういうふうにしてほしいけど現状できない)
 - [公式GitHubのREADME](https://github.com/philc/vimium)
 - [参考資料](https://qiita.com/satoshi03/items/9fdfcd0e46e095ec68c1)

e.g. 
 - `H`: 戻る
 - `L`: 進む
 - `J`: 左のタブ
 - `K`: 右のタブ
 - `gg`: 上へ
 - `GG`: 下へ
 - `f`: linkショートカットの表示
 - `i`: insert mode(vimium無効モード)
 - `ge`: URLをエディットするモード
 - `gi`: inputできるボックスまでジャンプ(e.g. yuotune, google, amazonの検索ボックスなど)
 - `/`: 文章検索(文章検索してヒットした単語をenterするとlinkがクリック候補になる、更にenterするとlinkが開く)

## CoCoCut
 - ストリーミングをダウンロードできるサービス
 - 仕組み的にはバッファリングを保存して単一のmp4に変換するというもののようである
 - (CoCoCutでの)ダウンロードが完了したあとに、保存のボタンを押して、そこから(webブラウザの)ダウンロードを完了させる必要がある

## Get cookies.txt LOCALLY
 - `cookies.txt`形式でログイン済みサイトのcookieをローカル保存する拡張
 - `chrome://extensions/shortcuts`からショートカットを割り当てるとクリックなしでエクスポートできて便利
 - 保存した`cookies.txt`はcurlやyt-dlpなどcookie対応ツールにそのまま渡せる
