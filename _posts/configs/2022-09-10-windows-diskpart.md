---
layout: post
title: "windows diskpart"
date: 2022-09-10
excerpt: "windows diskpartの使い方"
tags: ["windows", "microsoft"]
config: true
comments: false
sort_key: "2022-09-10"
update_dates: ["2022-09-10"]
---

# windows diskpartの使い方

## 概要
 - WindowsではOSが入ったパーティション(EFI, 回復パーティション)をGUIから初期化できない
   - CUIのコマンドで初期化できる

## 具体例

### ディスクの初期化
 - 手順
   - 管理者権限でpowershellを起動
   - `diskpart`でdiskpartに入る
   - `list disk`でディスク一覧を得る
     - diskの数字が確認できる
   - `select dick <num>`で選択
   - `clean all`で初期化できる
 - 参考
   - [diskpartコマンドでHDDを初期化する/Qiita](https://qiita.com/sawawawawawa/items/2ddabd3c62e43c7af436)

