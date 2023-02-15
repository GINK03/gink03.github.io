---
layout: post
title: "macOSのスクリーンショット"
date: 2023-02-15
excerpt: "macOSのスクリーンショットの方法とオプション"
tags: ["apple", "macos", "osx", "screenshots"]
config: true
comments: false
sort_key: "2023-02-15"
update_dates: ["2023-02-15"]
---

# macOSのスクリーンショットの方法とオプション

## スクリーンショットとスクリーンレコーディングの仕方
 - 範囲を指定したスクリーンショット
   - `⌘ + shift + 4`
 - 範囲を指定してスクリーンレコーディング
   - `⌘ + shift + 5`
     - 収録ボタンで録画を開始
     - 収録を停止するには`⌘ + shift + esc`
 - 参考
   - [Mac で画面を収録する方法](https://support.apple.com/ja-jp/HT208721)

## スクリーンショットのデータが保存されるパスの変更

```console
$ defaults write com.apple.screencapture location <output-path>
```
 
 - 参考
   - [How to Change Where Screenshots Are Saved on Mac](https://www.hellotech.com/guide/for/how-to-change-where-screenshots-are-saved-on-mac)

