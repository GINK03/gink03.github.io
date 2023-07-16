---
layout: post
title: "poetry"
date: 2021-08-04
excerpt: "poetryの使い方"
config: true
tag: ["poetry", "package manager", "python"]
comments: false
sort_key: "2021-10-26"
update_dates: ["2021-10-26","2021-10-18","2021-10-18","2021-08-12","2021-08-04"]
---

# poetryの使い方

## 概要
 - `requirements.txt`に変わるパッケージマネージメント
 - pipでインストールするより、厳格に依存を管理する
   - pipでは環境を作れるのに、poetryでは通らないケースがある
 - venvを`git init`の感覚で使用できる
   - 環境を汚染するかもしれないパッケージを使用してもグローバルを汚染しない

## ドキュメント
 - [公式](https://python-poetry.org/docs/)
 - [cheatsheet](https://gist.github.com/CarlosDomingues/b88df15749af23a463148bd2c2b9b3fb)

## install

**Linux, macOS, Windows(WSL)**
```console
$ curl -sSL https://install.python-poetry.org | python3 -
```

**ubuntu**
```console
$ sudo apt install python3-poetry
```

## uninstall

```console
$ curl -sSL https://install.python-poetry.org | python3 - --uninstall
$ rm -rf ~/.poetry
```

## projectの作成

```console
$ poetry new <project-name> # 新規にディレクトリを作成する場合
$ poetry new . # 現在のディレクトリを新規に管理する場合
```

## 既存のディレクトリをpoetry管理

```console
$ poetry init
```

## envに入る

```console
$ poetry shell
```

## envに入っているかどうかの確認

```console
$ which python3
# ~/Library/Caches/pypoetry/virtualenvs/tests-lightweight-mmm-tlHTGgKh-py3.10/bin/python3 などのようにpoetryのvenvのバイナリを指しているかで判断
```

## envの確認

```console
$ poetry env list
```

## envの削除

```console
$ poetry env remove env-name
```

## envの外からpoetryの環境でコマンドを実行する
 - `poetry run`を利用することで、`poetry shell`で発生する可能性がある(システムPATHが交じることによる)PATHの優先順位の問題による不整合などを回避できる

```console
$ poetry run python3 script-name # pythonのスクリプトを実行する場合
$ poetry run jupyter lab --port 2000 # PATH汚染を回避してjupyterを実行する場合
```

## pyenvと組み合わせて特定のバージョンのpythonを使用する
 - 例として`3.11.4`を使用する場合を記す

```console
$ cd <poetry-project>
$ pyenv local 3.11.4
# pyproject.tomlを編集してpythonバージョンを3.11.4に固定
$ poetry use env python3.11
$ poetry install
```

## パッケージのインストール

```console
$ poetry add package-name
```
 - addしたパッケージは自動で`poetry.toml`に追加される

## 依存のインストール

```console
$ poetry install
```
 - `poetry.toml`を参照してインストールされる

## poetry.lockとpoetry.toml
 - poetry.tomlだけでも環境構築できるが完全に再現するにはpoetry.lockも利用する


## scriptの実行

```console
$ poetry run script
```

## scriptの追加

 1. `project.toml`を編集

```toml
[tool.poetry.scripts]
test = 'scripts:test'
```

 2. ルートディレクトリに`scripts.py`を作成

```python
import subprocess

def test():
    """
    Run all unittests. Equivalent to:
    `poetry run python -u -m unittest discover`
    """
    subprocess.run(
        ['python', '-u', '-m', 'unittest', 'discover']
    )
```

 3. 実行

```console
$ poetry run test
```

## トラブルシューティング

### poetryのパッケージが壊れる
 - 原因
   - pythonのバージョンのアップグレードや混在で壊れる
 - 対応
   - poetryを一度アンイストールして、`rm -rf ~/.poetry`して再度インストール

### pyarrowがaddできない
 - 原因
   - `pip`を最新化する必要があった  
 - 対応
   - pipを最新化して`poetry add pip`する

## poetryを使ったDockerfileのテンプレート

```dockerfile
FROM python

ENV POETRY_VIRTUALENVS_CREATE=false # poetry経由でインストールしたライブラリを参照可能にするのに必要

RUN apt-get update -y && apt-get install -y
RUN pip install --upgrade pip && pip install poetry

WORKDIR /app
COPY . /app/

RUN poetry install --no-ansi --no-interaction

CMD sh -c "<command>"
```
