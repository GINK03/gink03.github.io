---
layout: post
title: "pylint"
date: "2022-01-05"
excerpt: "pylintの使い方"
project: false
config: true
tag: ["python3", "linter", "pylint", "vim"]
comments: false
sort_key: "2022-01-05"
update_dates: ["2022-01-05"]
---

# pylintの使い方

## 概要
 - python3のリンター
 - pythonスクリプトを動作させる前にわかるレベルのエラーのチェックが可能

## インストール

```console
$ python3 -m pip install pylint
```

## `.pylintrc`の作成

```console
$ pylint --generate-rcfile > ~/.pylintrc
```

## 設定項目
 - `jobs=4`
   - リンターの並列数
 - `py-version=3.9`
   - pythonの対象バージョン
 - `disable=...`
   - リント時に無視する機能

## consoleから使用する

```console
$ pylint <file.py>
************* Module a
.tmp/a.py:1:0: C0114: Missing module docstring (missing-module-docstring)
.tmp/a.py:7:0: E1101: Instance of 'Logger' has no 'unchi' member (no-member)
.tmp/a.py:1:0: W0611: Unused pandas imported as pd (unused-import)

-----------------------------------
Your code has been rated at 1.25/10
```

## neovimで使用する
 - ファイルを保存するたびに実行される

```vimscript
Plug 'dense-analysis/ale'
```

```vimscript
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_echo_msg_format='[%linter%][%severity%][%code%][%s]'
let b:ale_linters = ['flake8', 'pylint', 'mypy']
let b:ale_fixers = ['autopep8', 'yapf']
```

