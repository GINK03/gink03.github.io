---
layout: post
title: "jupyter install"
date: 2022-09-21
excerpt: "jupyterのinstallのチートシート"
tags: ["jupyter"]
kaggle: true
comments: false
sort_key: "2022-09-21"
update_dates: ["2022-09-21"]
---

# jupyterのinstallのチートシート

## 概要
 - 複数のpythonのバイナリがある場合、jupyterが正しくインストールされなかったり、問題を起こすことがある
   - jupyterの起動の際に`python3 -m notebook`で起動すると明示的に起動するバイナリが指定しやすい

---

## インストール

### jupyterlab app
 - [公式](https://github.com/jupyterlab/jupyterlab_app)からインストーラをダウンロードしてインストール
 - スタンドアロンでシステムとは別のpythonで動作する

### brew経由
```console
$ brew install jupyterlab
```
 - システムのpythonで動作するjupyter

### pip経由
```console
$ python3 -m pip install jupyter
```

### dockerを利用
```console
$ docker run -v $PWD/work:/home/jovyan -p 8888:8888 jupyter/scipy-notebook start-notebook.sh --NotebookApp.password="sha1:116ece6dcb3a:b8ce5afba56836dd6ba3f4e17405bc5064a630cd"
```
 - dockerのデフォルトユーザは`jovyan`
 - pipでjupyterをインストールするより安定する
 - [Jupyter Docker Stacks](https://jupyter-docker-stacks.readthedocs.io/en/latest/)

---

## 起動オプション

### ポートを指定して起動する
```console
$ jupyter notebook --port=<port-number>
```
 - ポートがすでに使用済みだと別のポートが割り振られる

### モジュールとして起動する
```console
$ python3 -m notebook
```
 - `jupyter`コマンドのPATHがおかしくなっているときに代替コマンドとして利用可能
   - ユーザスペースにpythonをインストールした際に発生しがちのトラブル

---

## jupyterへモジュールのインストール

### `pip`, `conda`でのモジュールインストール
```python
%pip install foo bar
```
 - パス参照が異なることがあるため、`%`を用い、`!`を使用しない

---

## jupyterがハングしたときの対応

### ターミナルから強制再起動
```console
$ pkill -f "python3 -m ipykernel_launcher"
```
 - killしても自動でカーネルがふたたび立ち上がる
