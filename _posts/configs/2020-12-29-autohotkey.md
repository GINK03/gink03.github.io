---
layout: post
title: "autohotkey"
excerpt: "autohotkeyの使い方"
date: 2020-12-29
tags: ["autohotkey", "windows"]
config: true
sort_key: "2022-05-30"
update_dates: ["2022-05-30", "2020-12-29"]
comments: false
---

# autohotkeyの使い方

## 概要
 - キーを置き換えたり、キーに特定のスクリプトを紐付けて自動化するソフトウェア
    - osxの[/karabiner/](/karabiner/)に相当する
 - 現在はmicrosoftのossである[/powertoys/](/powertoys/)が代替として公式の提供ということもあり優れている
 - autohotkeyは自動起動しない
 - autohotkeyは`.ahk`のスクリプトファイルをダブルクリックすることで起動できる
 - スクリプトファイルを更新した場合、ファイルをダブルクリックし、現在のautohotkeyプロセスを再起動することで設定が反映される

## インストール

```console
> sudo scoop install autohotkey
```
 - インストール後に再起動が必要

## 基本的なスクリプトの文法
 - `^`; CTRL
 - `#`; Win
 - `!`; Alt
 - `+`; Shift
 - `::`; 続く文をスクリプトとして実行
 - `return`; 複数行のときスクリプトのブロックを終了
 - `;`; コメント

## 基本的な使い方　

### スクリプトを用意する
 - デスクトップなど管理しやすい場所に`<your-script>.ahk`のファイルを作成する
 - 以下の内容を記す
```config
^+H::
MsgBox "Hello, world!"
MsgBox "hoge"
MsgBox "piyo"
return

^+C::Run calc.exe; Ctrl  + Shift + cで電卓を起動
^right::#^right; Ctrl + ->でCtrl + Win + -> を割り当て
^left::#^left
; ^space::Send, {vkF4sc029}; Ctrl + Spaceで全角半角ボタンに割り当て
```
 - `<youtr-script>.ahk`をダブルクリックすることで設定が反映される


## 参考
 - [Hotkeys/www.autohotkey.com](https://www.autohotkey.com/docs/Hotkeys.htm)
