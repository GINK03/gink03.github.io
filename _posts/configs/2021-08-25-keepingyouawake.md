---
layout: post
title: "KeepingYouAwake"
date: 2021-08-25
excerpt: "KeepingYouAwakeの使い方"
tags: ["macOS", "KeepingYouAwake"]
config: true
comments: false
sort_key: "2021-08-25"
update_dates: ["2021-08-25"]
---

# KeepingYouAwakeの使い方

## 概要
 - macOSでsleepを防ぐソフトウェア
   - ポリシー管理されたmacOSでも自動スリープを制御できるので、重い計算をするときなどに便利
 - insomuniaxがアップデートを辞めてしまったのでそのalternative

## install

```console
$ brew install cask keepingyouawake
```

## 使い方
 - `keepingyouawake`のキーワードで起動する
 - メニューバーにコーヒーカップのアイコンが出現する
   - 右クリックでメニューを開く
     - `Preferences...` -> `Start at login`
   - `白色のアイコン` -> `有効`
   - `透明のアイコン` -> `無効`

---

## 参考
 - [newmarcel/KeepingYouAwake](https://github.com/newmarcel/KeepingYouAwake)
