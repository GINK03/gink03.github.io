---
layout: post
title: "sharpkeys"
date: 2022-02-10
excerpt: "sharpkeysの使い方"
tags: ["sharpkeys", "karabiner", "windows", "powertoys"]
config: true
comments: false
sort_key: "2022-02-11"
update_dates: ["2022-02-11"]
---

# sharpkeysの使い方

## 概要
 - keychronなどで推奨されるwindows用のキースワップソフト
 - レジストリを置き換えることでキーを置き換える
 - powertoys, karabinerなどとは異なり、複数のキーのショートカットで何かを定義することはできない
 - 設定を行った後、再起動かログオフが必要になる

## インストール

```console
$ scoop bucket add extras
$ scoop install sharpkeys
```

## powertoysの機能より優れている点
 - powertoysではcaps lockの機能を完全に無効化する事ができない
   - 偶発的な操作でcaps lockを変更していても有効化されてしまう事がある
 - sharpkeysであればそのような事故はない

## 参考
 - [SHARPKEYS IS NOW IN THE MICROSOFT STORE!](https://www.randyrants.com/category/sharpkeys/)
