---
layout: post
title: "papermill"
date: 2022-03-22
excerpt: "papermillの使い方"
project: false
config: true
kaggle: true
tag: ["papermill", "jupyter"]
comments: false
---

# papermillの使い方

## 参考
 - jupyterノートブックをCLIで実行できる
 - パラメータ化したセルをインジェクトすることで引数付き関数のように扱える
 - CLIで実行した結果は別の出力したノートブックに保存される

## インストール

```console
$ python3 -m pip install papermill
```

## papermillを動作させるための前提

### jupyterノートブックのセルにタグ付けする
 - `[表示]` -> `[セルツールバー]` -> `[Tags]`
 - パラメータ化したセルに`parameters`と命名する

## 実行

```console
$ papermill any-notebook.ipynb output-notebook.ipynb -p a 10 -p b 20 -p c "foobar"
```

## 参考
 - [papermill.readthedocs.io](https://papermill.readthedocs.io/en/latest/index.html)
 - [Jupyter Notebook as a Function: Create Reusable Notebooks with Papermill](https://towardsdatascience.com/jupyter-notebook-as-a-function-create-reusable-notebooks-with-papermill-8f9bea5b9727)
