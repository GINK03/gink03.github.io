---
layout: post
title: "python pipx"
date: 2023-06-22
excerpt: "pythonのpipxの使い方"
config: true
tag: ["python", "pip", "pipx"]
comments: false
sort_key: "2023-06-22"
update_dates: ["2023-06-22"]
---

# pythonのpipxの使い方

## 概要
 - node.jsの`npx`に似た機能を提供する
 - pipがグローバルのパッケージを汚染してしまうので作られたツール
   - 別の環境にインストールされ、システムのパッケージと競合しない
   - [PEP 668](https://peps.python.org/pep-0668/)の提案に依拠する
 - ユースケースとしてコマンドラインで単独で動作するパッケージをインストールするのに適している
   - e.g. `yt-dlp`, `jupyterlab`, `pycowsay`など
 - [pypa](https://github.com/pypa/pipx)の提供なのでオーソライズドなもの 
 - インストールされた実態は`~/.local/pipx/venvs`

## インストール

**pip**
```console
$ python3 -m pip install --user pipx
$ python3 -m pipx ensurepath
```

**macOS**
```console
$ brew install pipx
```

**ubuntu/debian**
```console
$ sudo apt install pipx
```

## 基本的な操作

### パッケージのインストール

```console
$ pipx install <package-name>
```

### 実行するPythonのバイナリを指定し、パッケージ名にsuffixをつける
 - 例えば、`python3.11`で`jupyterlab`をインストールする場合は、`jupyterlab_3.11`という名前になる

```console
$ pipx install <package-name> --python $(which python3) --suffix <suffix>
```

#### 例; jupyterlabをインストールする

```console
$ pipx install jupyterlab --python $(which python3) --suffix _3.11
$ pipx inject jupyterlab_3.11 tqdm pandas seaborn scikit-learn ipywidgets theme-darcula joblib sortedcontainers
```

### すべてのパッケージのアップグレード

```console
$ pipx upgrade-all
```

### すべてのパッケージをアンインストール

```console
$ pipx uninstall-all
```

### パッケージの一覧を表示する

```console
$ pipx list
```

### インストールせずにパッケージを実行する

```console
$ pipx run <package-name>
```

**具体例**
```console
$ pipx run pycowsay moo

  ---
< moo >
  ---
   \   ^__^
    \  (oo)\_______
       (__)\       )\/\
           ||----w |
           ||     ||
```

## トラブルシューティング

### pipxのバージョンが古い
 - 対応
   - `python -m pip install --upgrade pip pipx`

### パッケージが壊れている
 - 対応
   - `pipx uninstall <package-name>`
   - `pipx install <package-name>`
