---
layout: post
title: "brew"
date: 2021-07-05
excerpt: "brewついて"
tags: ["brew", "macOS"]
config: true
comments: false
sort_key: "2022-01-22"
update_dates: ["2022-01-22","2021-12-27","2021-12-12","2021-11-01","2021-11-01","2021-10-27","2021-08-23","2021-08-10","2021-07-24","2021-07-05"]
---

# brewについて
 - osxのパッケージマネージャ
 - 特定のプログラムのデーモン化などができる

## インストール

```console
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## アンインストール

```console
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
```

## 基本的なインストール

```console
$ brew install <package-name>
```

**ビルドしてインストール**
```console
$ brew install <package-name> --build-from-source
```
 - apple silicon利用などでバイナリの互換性がないときに利用

## caskとは
 - GUIのパッケージをインストールするオプション
 - GUIアプリケーションのバージョン管理もできるので可能ならばbrew経由でインストールしたほうがいい

**例**  

```console
$ brew install firefox
```

**cask用のバージョン管理拡張機能**  
 - [homebrew-cask-upgrade](https://github.com/buo/homebrew-cask-upgrade)

## brewでインストールしたパッケージのdumpとrestore

**dump**
```console
$ brew bundle dump # Brewfileが生成される
```

**restore**
```console
$ brew bundle # Brewfileがあるディレクトリで実行する
```

## インストールされたパッケージ一覧

```console
$ brew list
```

## インストール可能なパッケージを探す

```console
$ brew search <keyword>
```
 - `cask`も含んで探す

## 問題点の提案の表示

```console
$ brew doctor
```

## brewのパッケージ情報の最新化

```console
$ brw update
```

## ソフトウェアのアップグレード

```console
$ brew upgrade
```

## brewがインストールされる先の確認

```console
$ echo `brew --prefix`
/usr/local
```
 - intelでは`/usr/local`
 - apple siliconでは`/opt/homebrew`

## github上にあるHEADを入れる

```console
$ brew install --HEAD <package>
```

## servicesとは
 - osxでdaemon管理するコマンド
 - 自分で登録するのは簡単ではなくplistというフォーマットの作成が必要

## トラブルシューティング

### 一部のソフトウェア(iftop, mtrなど)は特殊なpathになる

**brew infoで調べる**  
```console
$ brew info mtr
mtr: stable 0.94 (bottled), HEAD
'traceroute' and 'ping' in a single tool
https://www.bitwizard.nl/mtr/
/usr/local/Cellar/mtr/0.94 (12 files, 255.4KB) *
  Poured from bottle on 2021-12-12 at 10:50:06
From: https://github.com/Homebrew/homebrew-core/blob/HEAD/Formula/mtr.rb
License: GPL-2.0-only
```

**インストールされたパスの下に実行ファイルが存在する**  

```console
$ ls /usr/local/Cellar/mtr/0.94/sbin/mtr
/usr/local/Cellar/mtr/0.94/sbin/mtr
```

 - これはlinuxでsbinに該当するコマンドがosxでは書き込みできないので`/usr/local/sbin`にバイナリのリンクが生成されるためである  
 - `brew link <package-name>`でわかりやすいパスに配置される

