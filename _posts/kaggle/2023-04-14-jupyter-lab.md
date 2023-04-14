---
layout: post
title: "jupyter lab"
date: 2023-04-14
excerpt: "jupyter labの使い方"
tags: ["jupyter", "jupyter lab"]
kaggle: true
comments: false
sort_key: "2023-04-14"
update_dates: ["2023-04-14"]
---

# jupyter labの使い方

## 概要 
 - jupyter classicでは動作しない拡張機能がjupyter labで動作することがある
 - jupyter classicより機能が増加してい
 - OSのpythonは不整合を起こすことがあるからvertualenvなどで環境を分けたほうが良い

## インストール

```console
$ python3 -m pip install jupyterlab
$ python3 -m pip install ipywidgets
```

## 起動

```console
$ python3 -m jupyter lab --port XXX
```

### 起動オプション
 - `jupyter lab`
   - labで起動
 - `jupyter notebook`
   - classicで起動
 - `jupyter console`
   - consoleで起動

## ショートカット
 - カーソルがセルのそとにいる状態
   - `a`; 上にセルを追加
   - `b`; 下にセルを追加
   - `dd`; セルを削除
   - `y`; コードセルに変更
   - `m`; マークダウンセルに変更

## カラーテーマのインストール

```console
$ python3 -m pip install theme-darcula
```

## トラブルシューティング

### ipywidgetsに依存したライブラリが動作しない
 - 原因
   - adblockによりjavascriptが実行されていない
 - 対応
   - adblockを利用していないブラウザで実行する
