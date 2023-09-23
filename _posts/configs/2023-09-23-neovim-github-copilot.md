---
layout: post
title:  "neovim github copilot"
date: "2023-03-25"
excerpt: "neovim github copilotの使い方"
project: false
config: true
tag: ["neovim", "vim", "github", "copilot", "lua"]
comments: false
sort_key: "2023-09-23"
update_dates: ["2023-09-23"]
---

# neovim github copilotの使い方

## 概要
 - vscodeのgithub copilotのようにneovimでgithub copilotを使うことができる

## インストール
 - 現状、`plug`や`packer`経由でインストールしないほうが安定している

```console
$ git clone https://github.com/github/copilot.vim.git \
  ~/.config/nvim/pack/github/start/copilot.vim
```

## 認証
 - 一部のneovimのプラグインが干渉して認証プロセスが見ずらいことがある

```vim
:Copilot setup
```

## 設定

### markdownでの補完を有効化

```lua
-- マークダウンで有効化
vim.g.copilot_filetypes = {markdown = true}
```

## 参考
 - [github/copilot.vim](https://github.com/github/copilot.vim)
