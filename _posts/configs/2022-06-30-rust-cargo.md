---
layout: post
title: "rust cargo"
date: 2022-06-30
excerpt: "cargoの使い方"
tags: ["rust", "cargo"]
config: true
comments: false
sort_key: "2022-06-30"
update_dates: ["2022-06-30"]
---

# cargoの使い方

## 概要
 - rustのパッケージマネージャ兼ビルドツール
 - インストール手順は[/rust/](/rust/)
 - ビルドの依存を`Cargo.toml`に記す
   - ローカルにindexを持っており、このデータを更新するには`cargo update`する

## よく使うコマンド

### 新規プロジェクトを作成

```console
$ cargo new <project-name>
```
 - `project-name`のディレクトリが作成される

### ビルド

```console
$ cargo build
```

### 実行

```console
$ cargo run
```

### プロジェクトのインストール

```console
$ cargo install <project-name>
```
 - デフォルトでは`$HOME/.cargo/bin`にインストールされる
