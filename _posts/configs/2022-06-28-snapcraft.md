---
layout: post
title: "snapcraft"
date: 2022-06-28
excerpt: "snapcraftの使い方"
tags: ["snap", "snapcraft"]
config: true
comments: false
sort_key: "2022-06-28"
update_dates: ["2022-06-28"]
---

# snapcraftの使い方

## 概要
 - ubuntuを開発しているcanonicalが開発するソフトウェアパッケージ
 - dockerなどのように名前空間で分離するタイプではなさそうで、動作が名前空間タイプより遅い
 - `snap`がパッケージマネージャで、`snapcraft`がsnapパッケージを作成するソフトウェア
   - `snapcraft`がログインできないなど、挙動が怪しい

## インストール

**ubuntu**  
```console
$ sudo apt install snap
```

## snapの基本的な使い方

### ログイン

```console
$ snap login 
```
 - Ubuntu Oneアカウントでログイン
 - ログインした状態でないと、パッケージのインストールに管理者権限が必要になる

### パッケージのインストール

```console
$ snap install <package-name>
```

#### `--classic`オプションの意味
 - 独立したパッケージとしてインストール出来ないという意味
 - もしかしたら実行している環境に影響を与える可能性がある

## 参考
 - [Snap documentation](https://snapcraft.io/docs)
 

