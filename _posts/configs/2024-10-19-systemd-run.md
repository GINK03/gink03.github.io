---
layout: post
title: "systemd-run"
date: 2024-10-19
excerpt: "systemd-runコマンドについて"
tags: ["systemd", "systemd-run"]
config: true
comments: false
sort_key: "2024-10-19"
update_dates: ["2024-10-19"]
---

# systemd-runコマンドについて

## 概要
 - コマンドをsystemdのユニットとして実行するコマンド
 - cgroupを内部的に使用しており、リソースの制限や監視が可能

## 引数
 - `--unit=UNIT` : ユニット名を指定
 - `--scope` : ユニットをスコープユニット(一時的なユニット)として実行
 - `--user` : ユーザーユニットとして実行
 - `-p` : ユニットのプロパティを指定
   - `MemoryMax=16G` : メモリの最大使用量を16GBに制限
   - `CPUQuota=50%` : CPUの使用率を50%に制限

## リソースを制限して実行

**jupyter labをメモリ16GBまで使用して実行**

```console
$ systemd-run --user --scope -p MemoryMax=16G jupyter lab --port 20000 --ip '0.0.0.0'
```
