---
layout: post
title:  "neovim surround" 
date: "2023-12-17"
excerpt: "neovim surroundの使い方"
project: false
config: true
tag: ["neovim", "vim", "vim-surround", "nvim-surround"]
comments: false
sort_key: "2023-12-17"
update_dates: ["2023-12-17"]
---

# neovim surroundの使い方

## 概要
 - neovim用のvim-surround
 - 特定の文字列をカッコや"などで囲むことができる

## 使用例

### normal modeでカッコで囲む
 - `ysiw(`
   - カーソル位置の単語を`()`で囲む

### visual modeでカッコで囲む
 - `S(`
   - visual modeで選択した範囲を`()`で囲む

## 参考
 - [kylechui/nvim-surround](https://github.com/kylechui/nvim-surround)
