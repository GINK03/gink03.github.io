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
 - プロジェクトのルートに`.ruff.toml`を作成することで設定可能

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


## 設定例

**.ruff.toml**
```toml
exclude = [
    ".git"
]
line-length = 88
indent-width = 4
target-version = "py311"

[lint]
select = ["E4", "E7", "E9", "F"]
ignore = []

fixable = ["ALL"]
unfixable = []

[format]
quote-style = "single"
```

**pre-commitに設定**
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
        exclude: __init__\.py
      # Run the formatter.
      - id: ruff-format
        types_or: [ python, pyi, jupyter ]
        exclude: __init__\.py
```

**GitHub actionsでの設定**
 - [/github-actions-workflows/](/github-actions-workflows/)

## 参考
 - [Configuring Ruff](https://docs.astral.sh/ruff/configuration/)
