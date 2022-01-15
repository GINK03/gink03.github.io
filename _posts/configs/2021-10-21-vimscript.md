---
layout: post
title: "vimscript"
date: "2021-10-21"
excerpt: "vimscriptの使い方"
project: false
config: true
tag: ["vimscript", "neovim", "vim"]
comments: false
---

# vimscriptの使い方

## 概要
 - `init.vim`, `.vimrc`で動作するスクリプト

## ドキュメント
 - [vimhelp.org](https://vimhelp.org/)
 - [有志による日本語訳](https://vim-jp.org/vimdoc-ja/)

## vimscriptのロード順序
読み込まれる順序があり、プラグインによってキーマップやグローバル変数が書き換えられてしまうことがある   
そのため、ハイライト情報やキーマップの設定は`after/plugin/*.vim`に記したほうが安全である  
 1. `init.vim`
 2. ユーザが追加したプラグイン
 3. `after/plugin/*.vim`


## 正規表現の変数マッチ
 - `=~`
 - `=~#`
 - `=~?`

## 定義した関数の呼び出し

```vimscript
:call <defined-function>()
```

## ハイライト一覧

```vimscript
:highlight
```

## マップされているショートカットの確認

```vimscript
:map
```
 - 先頭の文字が共通するショートカットがあるとどちらかを判定するために遅延が入る

## リーダーキーボードの定義

```vimscript
let mapleader = "\<Space>"
```

## インクリメンタルサーチの結果、色をもとに戻す

```vimscript
:nohl
```

## 特殊変数
 - `expand('%:p')`
   - 編集中のフルパス
 - `@%`
   - 編集中のファイル名

## 各種関数

### line('$')
 - 現在開いているファイルの行数

### char2nr関数
 - 文字を数字のコードに変換

### nr2char関数
 - 数字をコードとみなし対応する文字に変換

### matchaddpos関数
 - 特定の範囲をハイライトする関数
 - `matchaddpos("HighlightRule",[[h, w, length], 0])`

### echo関数
 - `echo "string"`
   - stringを出力

### getpos関数
 - マークや今いる箇所のポジションを返す
 - `getpos(".")`
   - 現在のポジションを返す
 - `getpos("'a")`
   - マーク`a`の場所を返す

### setpos関数
 - マークの設定やポジションのジャンプ
 - `setpos("'a", [h, w])`
   - `[h, w]`にマーク`a`を設定

### getline関数
 - `getline(.)`
   - いまの関数の文字
 - `getline(1)`
   - 先頭の文字
 - `getline(1, 5)`
   - 1 ~ 5

### system関数
 - systemコールを行える関数
 - 引数を文字列で取得できる
 - 結果には末端処理がされていないのでtrim関数を掛ける必要がある

**例**  
 - python pathを得る

```vimscript
:echo trim(system('which python3'))

" /usr/bin/python3
```

### command関数
 - コマンドを定義する関数

**executeで実行する方法**  
```vimscript
command <Command-name> execute "call <Function-name>()"
```

**関数を引数付きで呼び出す方法**  
```vimscript
command -nargs=* <Command-name> call <Function-name>(<f-args>)
```

### timer_start関数
 - 指定のmillisec後に指定のコマンドを実行する
 - 疑似マルチスレッドのようなことができ、特定の関数を明示的にあとにロードさせたい時に使える

```vimscript
:let timer = timer_start(500,
                        \ {-> execute("echo 'Handler called'", "")},
                        \ {'repeat': 3})
" 3回, Hander calledと表示される
```

### :scriptnames
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

## テーマを作成
 - 前提
   - treesitterや他の特殊なテーマが有効になっていないこと
   - 作成した設定が最後に描画されないと反映されないので、他のテーマを読み込んだりしておらず`:set syntax=off`されていること

**pythonの色設定の例**  
```vimscript
" for, inをカラーリング
syn match pythonFor /\vfor\s/
hi def link pythonFor Macro
syn match pythonIn /\sin\s/
hi def link pythonIn Macro
hi Macro ctermfg=182 ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE

" import, asをカラーリング
syn match pythonImport /\vimport\ze\s/
syn match pythonAs /\sas\ze\s/
hi def link pythonImport Include
hi def link pythonAs Include
hi Include ctermfg=192 ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE

" defをカラーリング
syn match pythonDefine /\vdef\s/
hi def link pythonDefine Define
hi Define ctermfg=202 ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
```
 - [HEADファイル](https://bitbucket.org/nardtree/gimpei-dot-files/src/master/files/nvim/colors/monokai-high.vim)
 - 正規表現でハイライトルールを作成する
   - `\v`はindentの始まりにマッチする
   - `\ze`は色を塗る末尾

**例**  

<div>
  <img src="https://user-images.githubusercontent.com/4949982/148197983-085bef50-8669-467d-b2dd-d5c6ade89ff7.png">
</div>
