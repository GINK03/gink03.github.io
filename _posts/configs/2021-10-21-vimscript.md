---
layout: post
title: "vim script"
date: "2021-10-21"
excerpt: "vim scriptの使い方"
project: false
config: true
tag: ["vim script", "neovim", "vim"]
comments: false
---

# vim scriptの使い方

## 概要
 - `.vimrc`で動作するスクリプト

## 各種関数

### system
 - systemコールを行える関数
 - 引数を文字列で取得できる
 - 結果には末端処理がされていないのでtrim関数を掛ける必要がある

**例**  
 - python pathを得る

```
:echo trim(system('which python3'))

" /usr/bin/python3
```
