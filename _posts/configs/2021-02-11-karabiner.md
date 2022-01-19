---
layout: post
title: "karabiner elements"
date: 2021-02-11
excerpt: "karabiner elementsの概要と使い方"
tags: ["karabiner", "osx", "karabiner-elements"]
config: true
comments: false
---

# karabiner elementの概要と使い方

## 概要
macosxのシステムのキーボードの動きに対してフックを掛けて任意のキーを別の任意のキーに変換する、任意のキーショートカットを任意のシェルスクリプトに割り当てることができるソフトウェア


## インストール

**ダウンロード**  
 - [github releases](https://github.com/pqrs-org/Karabiner-Elements/releases)
 - インストール後は権限の許可と再起動が必要
   - 本当に有効になっているかの確認
     - 適当なキーを別なキーに変換して変換できているか確認する

**brew**  
```console
$ brew install karabiner-elements
```

## アンインストール

**command**  
```console
$ bash '/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/scripts/uninstall/deactivate_driver.sh'
$ sudo '/Library/Application Support/org.pqrs/Karabiner-Elements/uninstall.sh'
```

 - [参考](https://karabiner-elements.pqrs.org/docs/manual/operation/uninstall/)

## Simple modifications
単にキーを置き換える
 - e.g. 
   - `caps lock` -> `left_control`
   - `caps lock`の置き換えはシステム設定からも行えるが、Complex modificationsを利用する際は置き換えたキーとして認識されないので、Simple modificationsも設定する必要がある

## Complex modifications
任意のキーボードショートカットを与える

 - `~/.config/karabiner/karabiner.json`に設定ファイルが作成されるのでこれを編集して新規ショートカットの追加と編集を行う
 - `karabiner.json`の設定が読めない・間違っているなどとき、`karabiner-element`アプリのgui表示から設定が消える
 - バージョンの差があるのか、ネット上の設定をコピペしても動かないことがある
 - `simultaneous`というキーのコンビネーションはかなり挙動がシビアであり、結構入力が難しい

## インターネットのユーザが作成したmodifications
 - [link](https://ke-complex-modifications.pqrs.org/)
 - Microsoft RDPでコマンドをctrlにアプリが起動中のときのみ置き換える設定などがあり、便利である

## 使用している`karabiner.json`

[gistでホストしている`karabiner.json`ファイル](https://gist.github.com/GINK03/7d646e1da20af7e51b30759f1b46d441)


**概要**
 - `alt+hjkl`
   - マウスをキーボードで動かす
 - `alt+i`
   - マウスの右クリック
 - `ctrl+alt+t`
   - `iterm2`を新規ウィンドウで立ち上げ
 - `ctrl+alt+c`
   - `google chrome`を新規ウィンドウで立ち上げ
 - `ctrl+alt+f`
   - `finder`を立ち上げ
 - `s+1(900ms以内)`
   - AirPodsに音声を切り替え
 - `s+2(900ms以内)`
   - Displayに音声切り替え

## apple script(osascript)について
MacOSXの挙動を制御しているのは`apple script`なので特定のアプリになにかメッセージを与えるときには、`apple script`を実行する`shell script`を記述すれば良い  

作成した`apple script`は[gist](https://gist.github.com/GINK03/7d646e1da20af7e51b30759f1b46d441)でホストしている
