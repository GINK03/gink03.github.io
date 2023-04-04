---
layout: post
title: "ssh config"
date: 2023-04-04
excerpt: "sshのconfigの設定"
project: false
config: true
tag: ["ssh", "ssh-keygen", "sshの設定"]
comments: false
sort_key: "2023-04-04"
update_dates: ["2023-04-04"]
---

# sshのconfigの設定

## 概要
 - クライアントサイドの設定のこと
 - `~/.ssh/config`
 - ホストごとに設定でき、ワイルドカードを利用できる

## 設定項目
 - `User`
   - デフォルトでどのユーザでログインするか
 - `StrictHostKeyChecking`
   - 接続先のフィンガープリントが異なっているときに厳格にするかしないか
 - `IdentityFile`
   - 秘密鍵のpath
 - `IdentitiesOnly`
   - 秘密鍵が必要かどうか
 - `TCPKeepAlive`
   - 接続状態を継続したいかどうか

## 筆者の設定の例
   - [ssh_config](https://bitbucket.org/nardtree/gimpei-dot-files/src/master/files/ssh_config)
