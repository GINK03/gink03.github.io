---
layout: post
title: "jupyter magic commands"
date: 2023-12-16
excerpt: "jupyter magic commandsの使い方"
tag: ["jupyter", "kaggle", "python"]
comments: false
sort_key: "2023-11-18"
update_dates: ["2023-11-18"]
---

# jupyter magic commandsの使い方

## 概要
 - pythonのプログラムとは別にjupyter独自のコマンドがある
 - セルの先頭に`%`, `%%`をつけることで実行できる

## 代表的なマジックコマンドの使用例

### `%%time`, `%time`
 - `%time`
   - 次の行の実行時間を測定する
 - `%%time`
   - セル全体の実行時間を測定する

### `%env`
 - 環境変数を設定する

```python
%env OPENAI_API_KEY=xxxxxxxxxxxxxxxxxxxx
```

### `%%writefile <output-name>`
 - セルに記述するとセルの内容がファイルとして出力される
 - e.g.
   - `%% writefile a.py`
     - `a.py`で出力する

### `%%bash`
 - セルの最初に記述するとセルがshell scriptになる

### `%watermark`
 - 実行している`os`, `マシンスペック`, `python`, `jupyter`の環境を表示するmagic

```console
%pip install watermark # 必要ならば
%load_ext watermark
%watermark
Python implementation: CPython
Python version       : 3.10.12
IPython version      : 7.34.0

Compiler    : GCC 11.4.0
OS          : Linux
Release     : 6.1.58+
Machine     : x86_64
Processor   : x86_64
CPU cores   : 2
Architecture: 64bit
```

### `%autoreload`の使い方
 - 自作したpythonモジュール等をimportたびに更新するmagic

```python
%load_ext autoreload
%autoreload 2
```
