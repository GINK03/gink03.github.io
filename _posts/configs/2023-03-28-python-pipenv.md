---
layout: post
title: "pipenv"
date: 2023-03-28
excerpt: "pythonのpipenvの使い方"
config: true
tag: ["python", "library", "pipenv", "pip"]
comments: false
sort_key: "2023-03-28"
update_dates: ["2023-03-28"]
---

# pythonのpipenvの使い方

## 概要
 - [/pip/](/python-pip/)よりしっかりしていて[/poetry/](/python-poetry/)より簡単
 - `Pipfile`, `Pipfile.lock`が作成されるのでこれをシェアすることで環境を再現する

## インストール

```console
$ python3 -m pip install pipenv
```

## 基本的な使い方

### 初期化
 - 空の`Pipfile`, `Pipfile.lock`を作成する

```console
$ pipenv lock
```

### 環境に変更する

```console
$ pipenv shell
```

### Pipfile・環境にパッケージを追加する

```console
$ pipenv install <package-name>
```

### Pipfileの内容を環境に反映する

```console
$ pipenv install
```

### system環境にPipfileの内容を反映する

```console
$ pipenv install --system
```

## Dockerfileの例

```dockerfile
FROM python:3.8-slim

ENV LANG C.UTF-8

# Directory creation
RUN mkdir /var/work
WORKDIR /var/work

# Installing the packages needed to build the environment
RUN apt update
RUN apt install -y --no-install-recommends \
    git \
    curl \
    lsb-release

# Removing unnecessary caches in package management
RUN apt-get clean

# Copy the executable file and pipenv file
COPY ./src/ ./
COPY ./Pipfile ./
COPY ./Pipfile.lock ./

# Creating a Python environment
RUN pip3 install --upgrade pip && \
    pip3 install pipenv && \
    pipenv install --system
```

---

## 参考
 - [Pipenvの基本的な使い方/pipenv-ja.readthedocs.io](https://pipenv-ja.readthedocs.io/ja/translate-ja/basics.html)
