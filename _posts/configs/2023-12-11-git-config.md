---
layout: post
title: "git config"
date: 2023-12-11
excerpt: "gitの設定"
project: false
config: true
tag: ["git", "github", "config"]
comments: false
sort_key: "2023-12-11"
update_dates: ["2023-12-11"]
---

# gitの設定

## 概要
 - git configコマンドまたは`~/.gitconfig`ファイルによって設定を行う

## `~/.gitconfig`の設定例

```conf
[user]
    email = gimpeik@icloud.com
    name = Gimpei Kobayashi
[core]
    quotepath = false
    editor = vim
[init]
    defaultBranch = main
```

## コマンドによる設定
 - ユーザ名の設定
   - `git config --global user.name "Gimpei Kobayashi"`
 - メールアドレスの設定
   - `git config --global user.email "gimpeik@icloud.com"`
 - デフォルトブランチの設定
   - `git config --global init.defaultBranch main`
 - デフォルトエディタの設定
   - `git config --global core.editor vim`
 - ファイル名の文字コードの設定
   - `git config --global core.quotepath false`

## 設定の確認
 - `git config --list`
