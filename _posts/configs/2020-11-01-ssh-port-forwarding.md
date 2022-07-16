---
layout: post
title: "sshのport forwarding"
date: 2020-11-01
excerpt: "sshのport forwardingの使い方"
config: true
tag: ["ssh", "sshd", "security", "linux", "windows"]
comments: false
sort_key: "2022-05-20"
update_dates: ["2022-07-16"]
---

# sshのport forwardingの使い方

## 概要
 - sshの機能の一つであるが、わかりにくく、syntaxが独立しているので別に扱う
   - 使用例
     - web GUIで設定しなくてはならない時
     - jupyterなど、そのまま公開するとリスクが有るソフトウェアなどを操作する時
     - APIのテスト等
   - 引数の種類
     - `-L`
       - ローカル側から接続する時
     - `-R`
       - リモート側から接続する時
   - よくわからなくなったら[/eternal-terminal/](/eternal-terminal/)を使うと早い

## syntax

```console
$ ssh -L <local-port>:<destination-server-ip>:<remote-port> <remote-hostname>
```
 - 正確なsyntax

**よくある使用例**
```console
$ ssh -L 18888:localhost:8888 jupyter-server
```
 - `jupyter-server`の`8888版ポート`を**ローカルの**`18888版ポート`に転送する

## 参考
 - [sshポートフォワーディング/Qiita](https://qiita.com/mechamogera/items/b1bb9130273deb9426f5)
 - [How to Set up SSH Tunneling (Port Forwarding)](https://linuxize.com/post/how-to-setup-ssh-tunneling/)
