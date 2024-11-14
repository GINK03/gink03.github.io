---
layout: post
title: "python packages"
date: 2024-11-14
excerpt: "pythonのパッケージ作成"
config: true
tag: ["python", "uv", "rye", "poetry"]
comments: false
sort_key: "2024-11-14"
update_dates: ["2024-11-14"]
---

# pythonのパッケージ作成

## 概要
 - 基本的には最小構成で以下があればパッケージとして成立する
   - `src/my_project/__init__.py`
   - `pyproject.toml`
 - `uv`や`rye`は`pyproject.toml`を生成するので、それを使うと楽

## ディレクトリ構成

```console
project-name/
├── src/
│   └── my_project/
│       ├── __init__.py
│       └── module.py
├── pyproject.toml
├── README.md
├── LICENSE
└── tests/
    └── test_module.py
```

## `pyproject.toml`の設定

```toml
[project]
name = "my_project"
version = "0.1.0"
description = "A sample Python package"
authors = ["Your Name <your.email@example.com>"]
license = "MIT"
readme = "README.md"
requires-python = ">=3.8"
dependencies = ["requests"]

[build-system]
requires = ["setuptools", "wheel"]
build-backend = "setuptools.build_meta"

[tool.setuptools]
packages = ["my_project"]
package-dir = {"" = "src"}

[project.optional-dependencies]
dev = ["pytest", "black", "mypy"]
```

## インストールの例

**githubからインストール**
```console
$ pip install git+https://github.com/username/project-name.git
```

**ローカルからインストール**
```console
$ pip install /path/to/project-name
```
