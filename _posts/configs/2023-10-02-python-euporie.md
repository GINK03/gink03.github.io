---
layout: post
title: "python euporie"
date: 2023-10-02
excerpt: "pythonのeuporieの概要と使い方"
config: true
tag: ["euporie", "python"]
comments: false
sort_key: "2023-10-02"
update_dates: ["2023-10-02"]
---

# pythonのeuporieの概要と使い方

## 概要
 - jupyter(ipythonのクライアント)をterminalで実行するためのツール 
 - kittyの画像表示プロトコルを使って画像を表示する機能がある
   - tmuxを使用した状態でも`--tmux-graphics`オプションをつけることで画像を表示できる

## インストール

```console
$ pipx install euporie juptyerlab pandas matplotlib
```

## 使い方

### (notebookを開いて)起動する

```console
$ euporie-notebook note.ipynb --tmux-graphics
```

## 参考
 - [Euporie’s Documentation](https://euporie.readthedocs.io/en/latest/)
