---
layout: post
title: "git pre-commit"
date: 2023-12-23
excerpt: "pre-commitの使い方"
project: false
config: true
tag: ["git", "pre-commit"]
comments: false
sort_key: "2023-12-23"
update_dates: ["2023-12-23"]
---

# pre-commitの使い方

## 概要
 - `git commit`時に、コミット前に何か処理を実行することができる
   - 例えば、コードのフォーマットを自動で行う

## インストール

**macOS**
```console
$ brew install pre-commit
```

**ubuntu, debian**
```console
$ pipx install pre-commit
```

## レポジトリに設定
 1. リポジトリのルートに`.pre-commit-config.yaml`を作成
 2. `.pre-commit-config.yaml`に、実行したいコマンドや設定を記述
 3. `pre-commit install`を実行して設定を有効化

## 手動で実行

```console
$ pre-commit run --all-files
```

## 設定例

**ruffでリントを実行**

```yaml
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    # Ruff version.
    rev: v0.1.9
    hooks:
      # Run the linter.
      - id: ruff
        types_or: [ python, pyi, jupyter ]
        args: [ --fix ]
      # Run the formatter.
      - id: ruff-format
        types_or: [ python, pyi, jupyter ]
```
