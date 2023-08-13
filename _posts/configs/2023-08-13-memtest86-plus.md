---
layout: post
title: "memtest86+"
date: "2023-08-13"
excerpt: "memtest86+の使い方"
project: false
config: true
tag: ["hardware", "memory", "memtest86+"]
comments: false
sort_key: "2023-08-13"
update_dates: ["2023-08-13"]
---

# memtest86+の使い方

## 概要
 - GNU GPL v2.0ライセンスのメモリテストツール
 - USBフラッシュメモリから直接起動するか、LinuxのGRUB menuから選択して起動することができる
 - 起動すると全自動でテストが始まる
   - `q`で終了
 - Pass回数という考え方があり、テストの通過回数が一回増えるとPass回数が一回増える
 - 1 Pass増えるのにDDR4 64GBのメモリで一時間かかる
 - 公式サイトからUSBフラッシュメモリにmemtest86+をインストールするツールを公開している

## 参考
 - [www.memtest.org](www.memtest.org)
