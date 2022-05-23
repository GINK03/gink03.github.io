---
layout: post
title: "firewalld"
date: "2021-12-13"
excerpt: "firewalldの設定と使い方"
project: false
config: true
tag: ["linux", "firewalld", "firewall-cmd"]
comments: false
---

# firewalldの設定と使い方

## 概要
 - linuxのfirewall設定ソフト

## インストール

**ubuntu, debian**  
```console
$ sudo apt install firewalld
```

## コマンド

```console
# firewall-cmd <sub-command> <arg>
```

## 引数
 - `--state`
 - `--list-all`
   - ゾーンの設定を確認
 - `--get-active-zones`
   - IFが属しているアクティブなゾーン
 - `--get-default-zone`
   - デフォルトゾーン
 - `--set-default-zone`
 - `--zone=<zone>`
   - zoneを指定
 - `--add-service=<service>`
   - serviceを通信許可
 - `--remove-service=<service>`
 - `--change-interface=<interface-name>`
   - インターフェースを変更
 - `--reload`
   - 設定を再読み込み
 - `--permanent`
   - 設定を恒久化
