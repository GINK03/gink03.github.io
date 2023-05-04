---
layout: post
title: "python invoke"
date: 2023-05-04
excerpt: "pythonのinvokeの使い方"
config: true
tag: ["python", "invoke"]
comments: false
sort_key: "2023-05-04"
update_dates: ["2023-05-04"]
---

# pythonのinvokeの使い方

## 概要
 - CLIコマンドをラップするライブラリ
 - [/python-fire/](/python-fire/)に似た機能を持つ
   - `fire`はコマンドを実行する目的ではない
 - `tasks.py`というファイル名でinvoke用のスクリプトを作成する必要がある
 - 関数名を引数に呼び出せるが、コマンドではアンダーバー(`_`)がハイフン(`-`)に置き換えられる

## インストール

**ダウンロード**
```console
$ pythno3 -m pip install invoke
```

## 具体例
 - gitで指定したブランチにチェックアウトする機能

**tasks.py**
```python
from invoke import task

@task
def git_checkout(c, branch):
    c.run(f"git checkout {branch}")
```

**実行**
```console
$ invoke git-checkout --branch=main # mainブランチをチェックアウトする例
```

## 参考
 - [Welcome to Invoke!](https://www.pyinvoke.org)
