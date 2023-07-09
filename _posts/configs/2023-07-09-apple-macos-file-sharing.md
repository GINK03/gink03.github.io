---
layout: post
title: "macOS file sharing"
date: 2023-07-09
excerpt: "macOSのfile sharing(共有ファイル・フォルダ)の設定"
tags: ["apple", "macos", "osx", "settings", "samba"]
config: true
comments: false
sort_key: "2023-07-09"
update_dates: ["2023-07-09"]
---

# macOSのfile sharing(共有ファイル・フォルダ)の設定

## 概要
 - macOSにはデフォルトでファイルを共有する機能がある
   - 実態はsamba
   - macosのusernameとpasswordで認証させることができる
 - 共有したファイル・フォルダはiOSのファイルアプリからもアクセスできる
 - 外付けSSDを共有することも可能
 - [/tailscale/](/tailscale/)のようなp2p VPNでもファイルの共有が可能

## ファイル・フォルダ・ストレージデバイスを共有する
 - `System Settings` -> `Sharing` -> `file sharing`を有効化
 - `file sharing`の`(i)ボタン`から共有したいフォルダ/ストレージデバイスを選択・設定する

## 参考
 - [Macでファイル共有を設定する/support.apple.com](https://support.apple.com/ja-jp/guide/mac-help/mh17131/mac)
