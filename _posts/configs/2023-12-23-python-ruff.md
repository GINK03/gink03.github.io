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
$ pipx install pre-commit # pre-commitのインストール
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

**手動でpre-commitの実行**
```console
$ pre-commit run ruff --all-files
```

## 設定例

**.ruff.toml**
```toml
exclude = [
    ".git",
    "__pycache__",
    ".venv",
    "venv",
    ".mypy_cache",
    ".pytest_cache",
    "*.egg-info"
]
line-length = 88
indent-width = 4
target-version = "py311"

[lint]
select = [
    "E",     # pycodestyle errors
    "W",     # pycodestyle warnings
    "F",     # pyflakes
    "I",     # isort
    "B",     # flake8-bugbear
    "C4",    # flake8-comprehensions
    "UP",    # pyupgrade
    "ARG",   # flake8-unused-arguments
    "SIM",   # flake8-simplify
    "PTH",   # flake8-use-pathlib
]
extend-ignore = [
    "E501",  # line too long (handled by formatter)
    "B008",  # do not perform function calls in argument defaults
    "B905",  # zip() without an explicit strict= parameter
]

fixable = ["ALL"]
unfixable = []

[format]
quote-style = "double"
```

**pre-commitに設定**
```yaml
repos:
  - repo: https://github.com/astral-sh/ruff-pre-commit
    # Ruff version.
    rev: v0.12.3
    hooks:
      # Run the linter.
      - id: ruff
        types_or: [ python, pyi ]
        args: ["--fix", "--config=.ruff.toml"]
      # Run the formatter.
      - id: ruff-format
        types_or: [ python, pyi ]
```

**GitHub actionsでの設定**
 - [/github-actions-workflows/](/github-actions-workflows/)

## 参考
 - [Configuring Ruff](https://docs.astral.sh/ruff/configuration/)
