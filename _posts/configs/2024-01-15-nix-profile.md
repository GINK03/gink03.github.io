---
layout: post
title: "nix profile"
date: 2024-01-15
excerpt: "nix profileついて"
tags: ["nix", "nixpkgs", "macos", "linux", "nix", "package manager"]
config: true
comments: false
sort_key: "2024-01-15"
update_dates: ["2024-01-15"]
---

# nix profileについて

## 概要
 - [/nix-env/](/nix-env/)を整理したもの

## 基本的な使い方
 - `nix profile install nixpkgs#hoge` - インストール
 - `nix profile remove nixpkgs#hoge` - アンインストール
 - `nix profile list` - インストール済みのパッケージ一覧
 - `nix profile upgrade '.*'` - 全てのパッケージをアップデート

## パッケージの検索
 - `nix search nixpkgs` - パッケージの一覧
 - `nix search nixpkgs vim` - パッケージの検索(部分一致)
 - `nix search nixpkgs#vim` - パッケージの検索

## 参考
 - [nix profile - manage Nix profiles](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-profile)
