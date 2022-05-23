---
layout: post
title: "everything"
date: 2022-05-02
excerpt: "Windowsでのeverythingの使い方"
project: false
config: true
tag: ["everything", "windows", "フリーソフト"]
comments: false
sort_key: "2022-05-02"
update_dates: ["2022-05-02"]
---

# Windowsでのeverythingの使い方

## 概要
 - 一般的にWindowsはすべてのファイルシステムから特定のファイル名を持つものを検索するのが難しい
 - ある程度検索できるツールととしてeverythingというものがある
 - 正規表現もサポートされている
 - 起動するとインデックスファイルが作成され、クエリのたびに毎回全検索が走るわけではない
 - LinuxやUnixでは`$ find | grep "foobar"`があるので、必要なさそう

## インストール

```console
> sudo scoop install everything
```

## 設定
 - `ツール` -> `オプション` 
   - チェックを入れる
     - `管理者として実行`
     - `システム起動時に起動する`
     - `サービスに登録`

## 便利な使い方
 - [/powertoys/](/powertoys/)と連携してショートカットに登録しておくと便利
