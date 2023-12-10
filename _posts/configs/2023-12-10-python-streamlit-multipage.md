---
layout: post
title: "python streamlit multipage"
date: 2023-12-10
excerpt: "streamlitのmultipageの概要と使い方"
config: true
tag: ["streamlit", "python", "multipage"]
comments: false
sort_key: "2023-12-10"
update_dates: ["2023-12-10"]
---

# streamlitのmultipageの概要と使い方

## 概要
 - streamlitは基本はsingle pageで動作するが、multipageで動作させることもできる
 - 各pageは独立しているが、`st.session_state`を使うことで、page間でのデータのやり取りが可能

## multipageの有効化
 - ディレクトリ構造を設定することで有効化される

```console
$ tree
.
├── home.py
└── pages
    ├── 00_💫_aaa.py
    ├── 01_🍊_bbb.py
    └── 02_❤_ccc.py
```

## 各ページの並び順とアイコンの設定
 - ファイル名の先頭に`00_`などの数字をつけることで、並び順を設定できる
 - ファイル名の`_`で区切った2つ目の文字列が、アイコンとして表示される
