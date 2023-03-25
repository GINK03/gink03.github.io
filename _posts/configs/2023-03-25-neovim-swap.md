---
layout: post
title:  "neovim swap"
date: "2023-03-25"
excerpt: "neovim swapの扱い方"
project: false
config: true
tag: ["neovim", "vim", "lua", "luajit"]
comments: false
sort_key: "2023-03-25"
update_dates: ["2023-03-25"]
---

# neovim swapの扱い方

## 概要
 - vim, neovimが不測のシャットダウン時などに対応するためにswapファイルを作成する機能がある
 - swapファイルはバイナリの形で記録され、単純に比較したりできない

## swapファイルが作成された場合の対応法
 - `(R)リカバリー`モードでファイルを開く
 - リカバリーファイルを別名で保存
   - e.g. `:w /tmp/vim-tmp`
 - diffコマンドで差分を確認
   - e.g. `diff /tmp/vim-tmp <source-file>`
