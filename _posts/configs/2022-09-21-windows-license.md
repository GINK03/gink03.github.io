---
layout: post
title: "windows license認証"
date: 2022-09-20
excerpt: "windows license認証のまとめ"
tags: ["windows", "microsoft", "license", "ライセンス認証"]
config: true
comments: false
sort_key: "2022-09-21"
update_dates: ["2022-09-21"]
---

# windows licenseのまとめ

## 概要
 - EUでキーのリセールが認めれてから、Windowsが安く購入できるようになった
 - Windowsはハードウェアに情報を紐づけているようで、ハードウェアの大幅な変更を行った際などは、再認証が必要となる

## 過去買ったライセンスを再割当てする
 - `[Settings]` -> `[Activation]` -> `(購入済みのライセンスを入力)` -> `(失敗する)` -> `[trouble shootings]` -> `(ハードウェアの変更)` -> `(適切に廃棄したハードウェアを選択してライセンスが通るはず)`

## キーのリセラーで買った鍵を適応する
 - `(Kinguin等でライセンスを買う)` -> `(OEMライセンスなのでpowershell等から$ slui.exe 4で電話認証をかける)` -> `(認証完了)`

## 自動的にライセンス認証される条件
 - 過去、ライセンス認証が通ったハードウェアを使用しているとき(メインボートとCPUが一致しているとき),新規にWindowsをインストールすると自動的にライセン
ス認証される
