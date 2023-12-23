---
layout: post
title: "python ruff"
date: 2023-12-23
excerpt: "pythonのruffの概要と使い方"
config: true
tag: ["python", "linter", "ruff"]
comments: false
sort_key: "2023-12-23"
update_dates: ["2023-12-23"]
---

# pythonのruffの概要と使い方

## 概要
 - pythonのlinter
 - 2023年で人気
   - 高速

## インストール

```console
$ pipx install ruff
```

## 使い方

**ruffの実行**
```console
$ ruff check <file>
```

**ruffの実行(ディレクトリ)**
```console
$ ruff check <dir>
```

**エラーの自動修正**
```console
$ ruff check <file> --fix
```

**GitHub actionsでの設定**
 - [/github-actions-workflows/](/github-actions-workflows/)
