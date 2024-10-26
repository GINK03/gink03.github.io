---
layout: post
title: "systemd-journald"
date: 2024-10-26
excerpt: "systemd-journaldの使い方"
tags: ["linux", "systemd", "systemctl", "journalctl"]
config: true
comments: false
sort_key: "2024-10-26"
update_dates: ["2024-10-26"]
---

# systemd-journaldの使い方

## 概要
 - `systemd-journald`は`systemd`の一部であり、ログを管理するデーモン
 - `systemd-journald`はデフォルトでは`/run/log/journal`にログを保存する
   - 再起動時にログが消えるため、`/var/log/journal`にログを保存するように設定することが多い
 - `sudo` をつけるとすべてのログを見ることができる
   - `sudo`なしで見ることができるログはユーザが起動したサービスのログのみ

## 基本的なコマンド
 - `journalctl` - ログの表示
 - `journalctl -k` - カーネルのログを表示
 - `journalctl -u hoge.service` - サービスのログを表示
 - `journalctl --user -u hoge.service` - ユーザが起動したサービスのログを表示
 - `journalctl -g "キーワード"` - キーワードを含むログを表示
 - `journalctl -r` - ログを逆順に表示
 - `journalctl -o json-pretty` - JSON形式で表示
 - `journalctl -o short-iso` - timestampをISO8601形式で表示
 - `journalctl --disk-usage` - ログのディスク使用量を表示

## ログの恒久化

```console
$ sudo mkdir -p /var/log/journal
$ sudo systemd-tmpfiles --create --prefix /var/log/journal
$ sudo systemctl restart systemd-journald
```

## `journald`の設定
 - `/etc/systemd/journald.conf`に設定ファイルがある

```config
[Journal]
SystemMaxUse=100G
SystemKeepFree=10G
```

 - `SystemMaxUse` - ログの最大容量
 - `SystemKeepFree` - ログの最小容量
