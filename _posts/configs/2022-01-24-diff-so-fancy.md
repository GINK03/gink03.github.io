---
layout: post
title: "diff-so-fancy"
date: 2022-01-24
excerpt: "diff-so-fancyの使い方"
project: false
config: true
tag: ["diff", "npm", "diff-so-fancy"]
comments: false
sort_key: "2022-01-24"
update_dates: ["2022-01-24"]
---

# diff-so-fancyの使い方

## 概要
 - `git diff`や`diff`にてカラフルにdiffを表示する

## インストール

```console
$ sudo npm install diff-so-fancy -g
```

## gitコマンドへの登録

```shell
# 必須部分
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
git config --global interactive.diffFilter "diff-so-fancy --patch"

# 色とハイライトを変える
git config --global color.ui true

git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"

git config --global color.diff.meta       "11"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.func       "146 bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"
```
