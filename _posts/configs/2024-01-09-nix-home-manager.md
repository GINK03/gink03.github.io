---
layout: post
title: "nix home-manager"
date: 2024-01-09
excerpt: "nix home-managerの使い方"
tags: ["nix", "nixpkgs", "macos", "linux", "nix", "package manager"]
config: true
comments: false
sort_key: "2024-01-09"
update_dates: ["2024-01-09"]
---

# nix home-managerの使い方

## 概要
 - nixがインストールされていることが前提
 - dotfilesを管理するためのツール
 - ファイルへのシンボリックリンクを貼るだけでなく、nixpkgsのパッケージをインストールすることもできる

## インストール

```console
$ nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
$ nix-channel --update
$ nix-shell '<home-manager>' -A install
```

## 設定ファイルのパス
 - `~/.config/nixpkgs/home.nix`

## 基本的なコマンド
 - `home-manager swith`
   - 設定ファイルを反映
 - `home-manager edit`
   - 設定ファイルを編集
 - `home-manager build`
   - 設定ファイルをビルド
 - `home-manager generation`
   - 設定ファイルの履歴を確認
 - `home-manager packages`
   - インストールされているパッケージを確認

## 作成した設定ファイル
 - [home.nix](https://bitbucket.org/nardtree/gimpei-dot-files/src/master/files/home-manager/home.nix)
