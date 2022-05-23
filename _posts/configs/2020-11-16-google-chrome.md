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

# 便利な設定

## Google Chromeの更新後に見ていたページを復元する
 1. search barに`chrome://settings/?search=%E8%B5%B7%E5%8B%95%E6%99%82`を入力
 2. `[前回開いていたページを開く]`にチェックを入れる

## Google Chromeでsearch barを利用したカスタムショートカット(URLへのジャンプ)の登録
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

---

# 便利な機能

## タブの固定
 - 概要
   - 固定するとchromeの起動時に表示されるようになる
   - タブを閉じるショートカットを行うと消えてしまう
 - 操作
   - `タブの上で右クリック` -> `[固定]`を選択

---

# ショートカット

## `chrome://extensions/shortcuts`からaddonのon/offのショートカットを変更する
e.g. 
 - `⌘.` -> adblockのon/off
 - `⌘D` -> dark readerのon/off

## Linux + KDE Plasma
**Google Chromeのキーのリマップができないのでデフォルトで使うことになる**  
 - `[進む]` : `Alt+Right`
 - `[戻る]` : `Alt+Left`
 - `[次のタブを選択]` : `Ctrl+Tab`
 - `[前のタブを選択]` : `Ctrl+Shift+Tab`
 - `[全画面で表示]` : `F11`
 - `[新規タブ]` : `Ctrl+T`
 - `[タブを閉じる]` : `Ctrl+W`


## MacOSX
 - `[システム環境設定]` -> `[キーボード]` -> `[ショートカット]` -> `[アプリケーション]` -> `(Google Chromeを選択)` -> `(追加操作)`

**登録したほうがいい**  
(デフォルのショートカットキーも含む)  

 - `[次のタブを選択]` : `^]`
 - `[前のタブを選択]` : `^[`
 - `[進む]` : `⌘]`(default)
 - `[戻る]` : `⌘[`(default)
 - `[全画面表示で表示]` : `Shift+⌘F`(default)
 - `[ブックマークバーを常に表示]` : `Shift+⌘B`(default, バグることがある)
 - `[タブを開く]` : `⌘T`(default)
 - `[タブを閉じる]` : `⌘W`(default)
 - `[ページを再読み込み]` : `⌘R`(default)
 - `[場所を開く...]` : `^D`(⌘Dはブックマークとかぶる, alt+Dは動かない, ⌘Lは両手が必要になる。とても良く使っている)

**登録できないショートカット**  
 - `[閉じたタブを復元する]` : `⌘+Shift+T`

## Windows
 - PowerToysでキーをリマップするしかない
 - `Win+T` -> `Ctrl+T`
 - `Win+W` -> `Ctrl+W`
 - `Win+]` -> `Alt+Right`
 - `Win+[` -> `Alt+Left`
 - `Ctrl+]` -> `Ctrl+Tab` : 次のタブ
 - `Ctrl+[` -> `Ctrl+Shift+Tab` : 前のタブ
 - `Ctrl+Shift+F` -> `F11` : フルスクリーン


---

# extensions

## Shortkeys
*一部のLinux Desktopのようにバイナリで定義されたショートカットが変更できない場合、`Shortkeys`というGoogle Extentionでショートカットを変えることができる*  

JavaScriptで再現しているだけなので、画面にスコープがあたってないと動かないなどがあるが、多くは意図したとおりになる  

<div style="align: center !important;">
  <img src="https://user-images.githubusercontent.com/4949982/99498297-911a2e00-29ba-11eb-832e-c075d3adc086.png">
</div>

**以下は設定のjsonをshortenした内容**  
```json
[{"sites":"","sitesArray":[""],"key":"shift+left","action":"back"},{"key":"ctrl+]","action":"nexttab","sites":"","sitesArray":[""]},{"key":"ctrl+[","action":"prevtab","sites":"","sitesArray":[""]},{"key":"shift+]","action":"forward","sites":"","sitesArray":[""]},{"key":"shift+[","action":"back","sites":"","sitesArray":[""]},{"action":"hardreload","key":"ctrl+r","sites":"","sitesArray":[""]},{"sites":"","sitesArray":[""],"action":"newtab","key":"ctrl+t"},{"key":"shift+right","action":"forward","sites":"","sitesArray":[""]}]
```

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

## Video Speed Controller
 - [/video-speed-controller/](/video-speed-controller/)
