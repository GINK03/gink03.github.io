---
layout: post
title: "python venv"
date: 2023-12-25
excerpt: "pythonのvenvの使い方"
config: true
tag: ["python", "venv"]
comments: false
sort_key: "2023-12-25"
update_dates: ["2023-12-25"]
---

# pythonのvenvの使い方

## 概要
 - poetry, ryeでバージョン管理できなないパッケージが稀にあり、その場合はvenvを使用
   - venv環境下のpipはforce installが可能であり、柔軟性が高い 
 
## 環境の作成

```console
$ cd /path/to/project
$ python3 -m venv venv
$ source venv/bin/activate
```

## venv環境の判定
 - venv環境下では、`VIRTUAL_ENV`が設定される

```console
$ which python
/path/to/project/venv/bin/python
$ echo $VIRTUAL_ENV
/path/to/project/venv
```

## venv環境の削除
 - venv環境下では、`deactivate`コマンドでvenv環境を抜ける
 - venv環境を削除するには、venv環境を抜けた後にvenvディレクトリを削除

```console
$ deactivate
$ rm -rf venv
```
