---
layout: post
title: "Jupyter nbstripout"
date: 2026-03-27
excerpt: "Jupyterでnbstripoutを使用"
tag: ["jupyter", "kaggle", "python"]
comments: false
sort_key: "2026-03-27"
update_dates: ["2026-03-27"]
---

# Jupyterでnbstripoutを使用

## 概要
 - `.ipynb`ファイルからgit管理に不要な出力を削除するためのツール

## インストール
 - CLIコマンドとして利用される事が多いので、pipxでインストールするのがおすすめ

```console
$ pipx install nbstripout
```

## gitのプロジェクトにインストール
 - gitのプロジェクトにインストールするには、以下のコマンドを実行
 - `.gitattributes` に `*.ipynb filter=nbstripout` が追加される

```console
$ nbstripout --install --attributes .gitattributes
```

## インストール状態の確認

```console
$ nbstripout --status
```

 - インストール済みであれば、フィルタと`.gitattributes`の設定内容が表示される

## 主なオプション

 - `--keep-output`: 出力を削除しない
 - `--keep-count`: 実行カウント(`In [N]`)を削除しない
 - `--drop-empty-cells`: ソースが空のセルを削除する
 - `--max-size SIZE`: 指定サイズ以下の出力は保持する
 - `--extra-keys KEYS`: 追加で削除するメタデータキーをスペース区切りで指定
 - `--dry-run`: 実際には変更せず、対象ファイルを確認する

## pre-commitとの併用
 - pre-commitでnbstripoutを使用することも可能
 - ただし、コミット時にJupyterで開いている`.ipynb`ファイルをpre-commitが直接上書きするため、開いているノートブックの状態がおかしくなることがある
 - このためgit filterとして利用する方法（`nbstripout --install`）を推奨する
