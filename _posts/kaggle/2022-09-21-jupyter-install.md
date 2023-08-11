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
   - jupyterの起動の際に`python3 -m jupyter lab`, `python3 -m notebook`で起動すると明示的に起動するバイナリが指定しやすい

---

## 環境を分ける
 - システムのpythonがバージョンアップであったり、OSの都合であったりで、ライブラリの不整合が起こることがあり、[/poetry/](/python-poetry/)など環境を分割できるソフトウェアでpythonを分けると安全

```console
$ poerty new .
$ poetry add jupyterlab tqdm pandas seaborn scikit-learn ipywidgets theme-darcula joblib sortedcontainers \
pydata-google-auth google-auth google-auth-oauthlib google-auth-httplib2 google-api-python-client google-cloud-bigquery
$ poetry run jupyter lab --port 2000 --ip '0.0.0.0' # poetry shellはPATHを完全に書き換えないのでglobal環境とぶつかることがある
```

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

---

## 初期設定

### 設定ファイルのパス
   - `~/.jupyter/jupyter_notebook_config.py`

### 設定項目の説明
 - `c.NotebookApp.ip = "<ip-address>"`
   - IPアドレスの制限
   - `"0.0.0.0"`ですべてのアクセスを受け入れる
 - `c.NotebookApp.open_browser = <boolean>`
   - `False`で起動時にブラウザを立ち上げない
 - `c.NotebookApp.password = "<something-hash>"`
    - パスワードのハッシュ値を入れる

**設定の具体例**
```python
c.NotebookApp.ip = "0.0.0.0"
c.NotebookApp.open_browser = False
c.NotebookApp.password = u"sha1:f1d4830a643a:4a247c958f7a5c2a9cd4ba5b419a09a76ae2bfaf"
c.NotebookApp.port = 8888
```

### パスワードのhash値を作成する

**ipythonを使用する場合**
```python
In [1]: from notebook.auth import passwd
In [2]: passwd()
Enter password:
Verify password:
Out[2]: 'sha1:67c9e60bb8b6:9ffede0825894254b2e042ea597d771089e11aed'
```

**jupyterを使用する場合**
```python
In [1]: from IPython.lib import passwd
In [2]: passwd()
Enter password:
Verify password:
```
 - 参考
   - [Running a notebook server](https://jupyter-notebook.readthedocs.io/en/stable/public_server.html#preparing-a-hashed-password)
