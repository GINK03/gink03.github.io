---
layout: post
title: "python rye"
date: 2023-06-03
excerpt: "pythonのryeの使い方"
config: true
tag: ["python", "rye"]
comments: false
sort_key: "2023-06-03"
update_dates: ["2023-06-03"]
---

# pythonのryeの使い方

## 概要
 - poetryと同じようなツール
 - 哲学としてはconda, pipなど乱雑するパッケージマネージメント方式を考えないようにするようなツール
   - ryeとはライ麦畑のことらしい
   - [ryeがあることでマネージメントのスタンダードが一個増えてしまう自己矛盾](https://github.com/mitsuhiko/rye/discussions/6)がある
 
## poetryとの差分
 - pythonの任意のバージョンのインストールがryeのほうが楽に行える
 - 仮想環境のバイナリがプロジェクト配下に置かれるのでまとまりが良い(ように見える)

## インストール

```console
$ curl -sSf https://rye-up.com/get | bash
$ echo 'source "$HOME/.rye/env"' >> ~/.bashrc
$ source "$HOME/.rye/env"
```

## プロジェクトの始め方

```console
$ rye init <project-name> && cd <project-name> 
```

## 任意のpythonのバージョンに設定

```console
$ rye pin <version> # e.g. rye pin 3.11
```

## venvのアクティベーション

```console
$ . .venv/bin/activation
```

## パッケージの追加

```console
$ rye add <package-name> # e.g. rye add openai
```

## パッケージの仮想環境へのインストール

```console
$ rye sync 
```

## 参考
 - [Rye: An Experimental Package Management Solution for Python](https://rye-up.com/)