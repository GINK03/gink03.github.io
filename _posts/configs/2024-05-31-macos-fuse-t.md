---
layout: post
title: "fuse-t"
date: 2024-05-31
excerpt: "macOS fuse-tの概要"
tags: ["libfuse", "fuse-t", "macOS"]
config: true
comments: false
sort_key: "2024-05-31"
update_dates: ["2024-05-31"]
---

# macOS fuse-tの概要

## 概要
 - fuse-tはkext(カーネル拡張)を使用せず、ユーザーランドで動作するfuseのドロップイン代替
   - macFUSEはカーネル拡張を使用している
 - nfsの機能を拡張する形で作成されている

## インストール

```console
$ brew tap macos-fuse-t/homebrew-cask
$ brew install fuse-t
$ brew install fuse-t-sshfs
```

## トラブルシューティング
 - 問題
   - iPhoneの大量のファイルからmacOSのsshfsでマウントしたディレクトリにコピーを行うとmacOS・linuxがクラッシュする
 - 原因
   - 不明

## 参考
 - [Userspace FUSE for macOS](https://www.fuse-t.org/)
