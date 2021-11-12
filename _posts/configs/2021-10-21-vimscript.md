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

## オフィシャルドキュメント
 - [vimhelp.org](https://vimhelp.org/)

## 定義した関数の呼び出し

```vimscript
:call <defined-function>()
```

## リーダーキーボードの定義

```vimscript
let mapleader = "\<Space>"
```

## 各種関数

### system
 - systemコールを行える関数
 - 引数を文字列で取得できる
 - 結果には末端処理がされていないのでtrim関数を掛ける必要がある

**例**  
 - python pathを得る

```vimscript
:echo trim(system('which python3'))

" /usr/bin/python3
```

### scriptnames
 - ロードされているscriptを読み込み順で表示する
 - なにかのscriptが設定を上書きしてしまうなどがあれば順序を確認して整理することができる

## pythonバインディング

### ドキュメント
 - [https://vimhelp.org/if_pyth.txt.htm](https://vimhelp.org/if_pyth.txt.html#python-dynamic)

### 例; カラースキームのランダムセレクト

```vimscript
" colorschmeをランダムでセット
function! RndColo()
py3 << EOF
import random
import vim
colos = ["molokai", "solarized8_dark", "gruvbox", "1989", "Benokai", "0x7A69_dark", "iceberg"] # disable "nord"
colo = random.choice(colos)
vim.command("colorscheme " + colo)
print(colo + " was selected.")
EOF
endfunction
" :call RndColo() 
```

## concealing
 - 表示したくない文字列を隠す機能
 - visualモードでは表示されないがinsertモードでは表示される

```vimscript
function! Concealing()
    " markdownの長いurlをshortenする
    set conceallevel=3
    set concealcursor=n
    " syn cluster SClusters contains=STest
    syntax region STest start='\[.\+\](' end=')' contains=myStartTest,myEndTest oneline concealends
    syntax match myStartTest '(\ze.\+' contained conceal cchar=(
    syntax match myEndTest '(.\+)' contained conceal cchar=*
endfunction

:call Concealing()
```

 - 上記の例ではmarkdownのURL文字列を隠す
