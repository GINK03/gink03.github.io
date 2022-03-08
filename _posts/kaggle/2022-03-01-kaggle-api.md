---
layout: post
title: "kaggle api"
date: 2022-03-01
excerpt: "kaggle apiの使い方"
kaggle: true
hide_from_post: true
tag: ["statistics", "機械学習", "kaggle", "kaggle api"]
comments: false
---

# kaggle apiの使い方

## 概要
 - kaggleのデータセットをダウンロードしたりサブミッションを行ったりするAPIとそのインターフェース

## インストール

```console
$ python3 -m pip install kaggle
```

## クレデンシャルとそのパスと権限

#### パス

```console
$ ls ~/.kaggle/kaggle.json
```
 - 権限過剰な際は`chmod 400`する

