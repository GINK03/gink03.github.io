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
 - pipがグローバルのパッケージを汚染してしまうので作られたツール
   - 別の環境にインストールされ、システムのパッケージと競合しない
   - [PEP 668](https://peps.python.org/pep-0668/)の提案に依拠する
 - [pypa](https://github.com/pypa/pipx)の提供なのでオーソライズドなもの 

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

## パッケージのインストール

```console
$ pipx install <package-name>
```

## インストールせずにパッケージを実行する

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
