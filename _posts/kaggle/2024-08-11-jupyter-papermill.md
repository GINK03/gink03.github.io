---
layout: post
title: "jupyter papermill"
date: 2024-08-11
excerpt: "jupyter papermillの使い方"
tag: ["jupyter", "kaggle", "python"]
comments: false
sort_key: "2024-08-11"
update_dates: ["2024-08-11"]
---

# jupyter papermillの使い方

## 概要
 - jupyter notebookをコマンドラインから実行するためのツール
 - `parameters`というタグをつけたセルを指定して、そのセルの値を変更して実行することができる
   - jupyter labではView -> Property Inspector -> COMMAND TOOLS -> Cell Tagsで`parameters`を追加できる

## インストール

```console
$ pip install papermill
```

## 使い方
 - `output.ipynb`に`input.ipynb`の実行結果を保存する

```console
$ papermill input.ipynb output.ipynb -p param1 value1 -p param2 value2
```
