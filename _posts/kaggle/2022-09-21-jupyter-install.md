---
layout: post
title: "Jupyter install"
date: 2022-09-21
excerpt: "Jupyterのインストールのチートシート"
tag: ["jupyter"]
kaggle: true
comments: false
sort_key: "2022-09-21"
update_dates: ["2022-09-21"]
---

# Jupyterのインストールのチートシート

## 概要
 - 複数のPythonバイナリがある場合、Jupyterが正しくインストールされなかったり問題を起こすことがある
   - 起動は `python3 -m jupyter lab` や `python3 -m notebook` とすると、利用するPythonを明示できる

## Poetry, uvで環境を分けてインストールする
 - システムのPythonではライブラリの不整合が起こることがあり、[/poetry/](/python-poetry/)や[/python-uv/](/python-uv/)など環境を分離できるツールを用いると安全

```console
$ uv init .
$ uv add jupyterlab tqdm pandas seaborn scikit-learn ipywidgets joblib sortedcontainers \
    scipy lightgbm \
    pydata-google-auth google-auth google-auth-oauthlib google-auth-httplib2 google-api-python-client google-cloud-bigquery \
    pandas-gbq japanize-matplotlib \
    db-dtypes google-cloud-bigquery-storage neovim pip pyright google-cloud-secret-manager \
    openai tiktoken spacy requests jinja2 gspread \
    jedi-language-server jupytext \
    theme-darcula catppuccin-jupyterlab jupyterlab-miami-nights jupyterlab-simpledark
$ uv run jupyter lab --port 20000 --ip '0.0.0.0' --ServerApp.disable_check_xsrf=True
$ systemd-run --user --scope -p MemoryMax=16G uv run jupyter lab --port 20000 --ip '0.0.0.0' --ServerApp.disable_check_xsrf=True # Linuxでリソースを制限する場合
```

## その他のインストール方法

### JupyterLab App
 - [公式](https://github.com/jupyterlab/jupyterlab_app)からインストーラをダウンロードしてインストール
 - スタンドアロンでシステムとは別のPythonで動作する

### brew経由
```console
$ brew install jupyterlab
```
 - システムのPythonで動作するJupyter

### pip経由
```console
$ python3 -m pip install jupyter
```

### Dockerを利用
```console
$ docker run -v $PWD/work:/home/jovyan -p 8888:8888 jupyter/scipy-notebook start-notebook.sh --NotebookApp.password="sha1:116ece6dcb3a:b8ce5afba56836dd6ba3f4e17405bc5064a630cd"
```
 - Dockerのデフォルトユーザーは`jovyan`
 - pipでJupyterをインストールするより安定する
 - [Jupyter Docker Stacks](https://jupyter-docker-stacks.readthedocs.io/en/latest/)

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
   - ユーザー・スペースにPythonをインストールした際に発生しがちなトラブル

## Jupyterでのモジュールインストール

### `pip`, `conda`でのモジュールインストール
```python
%pip install foo bar
```
 - パス参照が異なることがあるため、`%`を用い、`!`を使用しない

## Jupyterがハングしたときの対応

### ターミナルから強制再起動
```console
$ pkill -f "python3 -m ipykernel_launcher"
```
 - killしても自動でカーネルが再起動する

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

### パスワードのハッシュ値を作成する

**Jupyter Notebookを使用する場合**
```python
In [1]: from notebook.auth import passwd
In [2]: passwd()
Enter password:
Verify password:
Out[2]: 'sha1:67c9e60bb8b6:9ffede0825894254b2e042ea597d771089e11aed'
```

**IPythonを使用する場合**
```python
In [1]: from IPython.lib import passwd
In [2]: passwd()
Enter password:
Verify password:
```
 - 参考
   - [Running a notebook server](https://jupyter-notebook.readthedocs.io/en/stable/public_server.html#preparing-a-hashed-password)
