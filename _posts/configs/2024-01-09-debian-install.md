---
layout: post
title: "debian"
date: 2024-01-09
excerpt: "debianのインストール"
tags: ["debian", "linux"]
config: true
comments: false
sort_key: "2024-01-09"
update_dates: ["2020-01-09"]
---

# debianのインストール

## debianのインストールメディアの入手方法
 - [Debian の CD](https://www.debian.org/CD/)からBitTorrentでダウンロードする

## debianのインストール方法
 - インストールメディアをUSBに焼く
 - USBから起動
 - (graphicでない)installを選択
 - 地域と言語
   - asia -> japan
   - 言語 -> american english
 - パッケージマネージャ
   - network mirrorを有効化する(有効化しないとCDからしか参照しなくなる)
     - インストール後に`/etc/apt/sources.list`を編集してmirrorを有効化・追加することもできる
 - 追加ソフトウェア
   - `ssh-server`を有効化
   - `non-free`を有効化

## 言語設定

### LC_ALLに`ja_JP.UTF-8`を設定する
 - `sudo vim /etc/default/locale`を開き、`LC_ALL=ja_JP.UTF-8`を追加する
 - `sudo locale-gen`を実行する
 - `sudo update-locale`を実行する
