---
layout: post
title: "windows powertoys"
date: 2022-02-10
excerpt: "powertoysの使い方"
tags: ["powertoys", "karabiner", "windows"]
config: true
comments: false
sort_key: "2022-02-11"
update_dates: ["2022-02-11"]
---

# powertoysの使い方

## 概要
 - microsoftが提供するmac osで便利であるけれどwindowsにないソフトウェアを提供している
   - powertoysが提供する機能と同等のmac osのソフトウェア
     - raycast
     - karabiner
     - keepyouawake

## 各機能
 - `常に手前に表示`
   - 概要
     - 特定のウィンドウを常に最前面に表示する
   - 使い方
     - `Ctrl + Win + T`
 - `Awake`
   - 概要
     - 常にスリープしない
 - `マウスユーティリティ`
   - 概要
     - マウスの検索を行ったり、蛍光ペン機能をつけたり
    - マウスの検索は誤爆が多いので無効化しておくとよい
 - `FancyZone`
   - 概要
     - 右左のウィンドウの2分割だけではなく、任意のテンプレートに分割する
     - mac osではraycastやmagnetが該当
   - 使い方
     - 分割したいウィンドウを`Shift押しながらドラッグ`移動できる
     - `Win+backquote`でFancyZoneの編集
     - Windowスナップのオーバーライドを有効にすると、tmuxのpaneの移動のイメージで移動、分割、配置ができる
 - `Keyboard Manager`
   - 概要
     - mac osのkarabinerと同様にキーの置き換えだったり、キーコンビネーションの定義ができる
     - [/rdp/](/rdp/)経由で用いるときに複雑なキーバンドをシングルキーで定義可能なのでホストマシンと干渉しなく、便利
 - `PowerToys Run`
   - 概要
     - mac osのraycastとほぼ同様（いくつかの機能は足らない）を提供する
   - 使い方
     - `Alt + Space`で起動
     - 右windowsボタンにkeyboard managerで複雑なショートカットを割り当て、それで起動する方法も便利
