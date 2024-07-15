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
   - pyenvの役割もrye単独で担っている
 - 哲学としてはconda, pipなど乱雑するパッケージマネージメント方式を考えないようにするようなツール
   - ryeとはライ麦畑のことらしい
   - [ryeがあることでマネージメントのスタンダードが一個増えてしまう自己矛盾](https://github.com/mitsuhiko/rye/discussions/6)がある
 - `rye add`で追加したパッケージは`project.toml`に記述される
   - パッケージのバージョンをあとから変更する際は`project.toml`を編集し`rye sync`を実行
 - 2024年7月現在、uvを開発しているAstralに移管された
 
## poetryとの差分
 - pythonの任意のバージョンのインストールがryeのほうが楽に行える
 - 仮想環境のバイナリがプロジェクト配下に置かれるのでまとまりが良い(ように見える)

## インストール

```console
$ curl -sSf https://rye.astral.sh/get | bash
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

## パッケージの追加
 - パッケージも追加してもsyncするまで実際にはインストールされない

```console
$ rye add <package-name> # e.g. rye add openai
```

## パッケージの仮想環境へのインストール

```console
$ rye sync 
```

## ryeの環境下でコマンドを実行
 - 固有で使用できるコマンドの一覧が引数なしで表示される

```console
$ rye run <command>
```

## venvのアクティベーション

```console
$ . .venv/bin/activation
```

## Dockerでryeのプロジェクトを実行する

**コンテナにryeをインストールしない場合**

```dockerfile
FROM python:3.11

RUN apt-get update -y && apt-get install -y
RUN pip install --upgrade pip

WORKDIR /app
COPY . /app/

# ryeのrequirements.lockをrequirements.txtに変換してからpipでインストール
RUN sed '/-e/d' requirements.lock > requirements.txt
RUN pip install -r requirements.txt

CMD sh -c "<command>"
```

## タスクランナーとしての利用
 - `[tool.rye.scripts]` にタスクを記述することで、`rye run <task-name>`で実行できる

**例**
```toml
[tool.rye.scripts]
test = { cmd = "pytest -s" }
```

**実行**
```console
$ rye run test
```

## トラブルシューティング
 - pyenvとryeを併用したときにpythonが起動しなくなる
   - 原因
     - pyenvのglobalのpythonが未設定の際に発生する
   - 対応
     - pyenvのglobalのpythonを設定する
       - `pyenv global <version>`

 - ryeとpyenvのpython環境名の非互換により、neovim, pyrightなどのpythonパスが正しく設定されない
   - 原因
     - ryeの命名規則は `cpython-x86_64-linux@3.11.5` などであるので、pyenvの命名規則とは異なる
   - 対応
     - pyenv側で環境に対してシンボリックリンクを張って同様の環境名を用意することで、neovim, pyrightなどのpythonパスの不具合を回避できる　

**修正例**
```console
$ ln -s $HOME/.pyenv/versions/3.11.5 $HOME/.pyenv/versions/cpython-x86_64-linux@3.11.5
```


## 参考
 - [Rye: An Experimental Package Management Solution for Python](https://rye-up.com/)
 - [Rye + Docker #239](https://github.com/mitsuhiko/rye/discussions/239)
