---
layout: post
title: "linux sudo" 
date: 2023-12-16
excerpt: "linuxのsudoについて"
config: true
tag: ["linux", "sudo"]
comments: false
sort_key: "2023-12-16"
update_dates: ["2023-12-16"]
---

# linuxのsudoについて

## 概要
 - sudoはsuper user doの略
 - root権限でコマンドを実行するためのコマンド
 - 一般ユーザーがroot権限でコマンドを実行するために使う

## コマンドの例とその意味
 - `sudo <command>`
   - commandをroot権限で実行する
 - `sudo -u <user> <command>`
   - userでcommandを実行する
 - `sudo -i`
   - rootユーザーになる
 - `sudo -s`
   - 現在のユーザーの環境変数を引き継いでrootユーザーになる
 - `sudo -l`
   - 現在のユーザーが実行できる特権コマンドを表示する

## 新規ユーザにsudo権限を付与する

**ユーザの追加**
```console
$ sudo adduser <user>
```

**sudoグループに追加**

```console
$ sudo usermod -aG sudo <user>
```

**visudoでsudoersファイルを編集**

```console
$ sudo visudo
# 以下の行を追加
<user>  ALL=(ALL:ALL) ALL
```

## sudoコマンド時にパスワードを省略する

**visudoでsudoersファイルを編集**

```console
$ sudo visudo
# 以下の行を追加
<user>  ALL=(ALL) NOPASSWD:ALL
```
