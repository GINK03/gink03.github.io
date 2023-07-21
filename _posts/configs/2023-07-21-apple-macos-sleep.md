---
layout: post
title: "macOS sleep" 
date: 2023-07-21
excerpt: "macOSのsleepの方法"
tags: ["apple", "macos", "osx", "settings", "sleep"]
config: true
comments: false
sort_key: "2023-07-21"
update_dates: ["2023-07-21"]
---

# macOSのsleepの方法

## 概要
 - macOSでCLIでsleepするにはコマンドを実行したバイナリ(またはアプリ)のシステムへの介入の承認が必要になる
   - 最初にGUIでの承認が必要
 - スリープにはいくつか種類があり、`通常スリープ`だとsshdがアクティブなのでリモートからアクセスできる

## CLIによるsleep

**osascript経由**
```console
$ osascript -e 'tell application "System Events" to sleep'
```

**pmset経由**
```console
$ pmset sleepnow
```
