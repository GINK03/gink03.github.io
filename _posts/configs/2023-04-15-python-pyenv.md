---
layout: post
title: "python pyenv"
date: 2023-04-15
excerpt: "pythonのpyenvの使い方"
config: true
tag: ["python", "pyenv"]
comments: false
sort_key: "2023-04-15"
update_dates: ["2023-04-15"]
---

# pythonのpyenvの使い方

## 概要
 - pyenvはvenvと別のもの
   - pyenvはpythonのバイナリを複数管理するためのソフトウェアで、venvは依存を隔離して別のパッケージ体系にするもの
 - poetryで指定したバージョンのpythonを利用するときなどに必要 

## 依存

**ubuntu, debian**
```console
$ sudo apt update
$	sudo apt install -y build-essential libssl-dev zlib1g-dev libbz2-dev \
  libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
  xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
```

## インストール

**ダウンロード**
```console
$ git clone https://github.com/pyenv/pyenv.git ~/.pyenv
```

**zshへ設定**
```shell
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
# poetryとの連携用の環境変数
export POETRY_PYENV_PLUGIN_ENABLE=1
```

## 判例
 - 一覧
   - `pyenv install --list`
 - 指定したバイナリのインストール
	 - `pyenv install <version-name>`
 - ローカルに設定する
	 - `pyenv local <version-name>`
 - ローカル環境から出る
	 - `pyenv local --unset`

## poetryで使う場合
 - 特定のバージョンで使用
   - `poetry env use <version-name>`
