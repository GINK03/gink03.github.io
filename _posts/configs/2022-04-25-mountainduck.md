---
layout: post
title: "Mountain Duck"
date: 2022-04-25
excerpt: "Mountain Duckの使い方"
project: false
config: true
tag: ["s3", "mountainduck", "windows", "osx"]
comments: false
---

# Mountain Duckの使い方

## 概要
 - 様々なオンラインストレージサービスをマウントしてフィアルシステムのように扱えるツール
 - GCSやS3をストレージとして扱うことがきでる
   - [/backblaze/](/backblaze/)のB2のようなS3互換のプロトコルのオブジェクトストレージをオンラインストレージとして使おうとすると、まともなクライアントがこれぐらいしか無い
 - シェアウェアである

## インストール

**osx**  
```console
$ brew install mountain-duck
```

**windows**  
```console
> choco install mountain-duck
```

## 購入とライセンスキーの認証
 1. 公式サイトでPayPalかクレジットカードで支払いを行う
 2. 登録したメールに認証キーファイルが送られてくる
 3. ダブルクリックするとmountainduckが起動してライセンスが通る
   - ライセンスは購入者のPCの範囲内であれば複数台インストールできる

## マウントポイント
 - osx
   - `~/Library/Group Containers/G69SCX94XU.duck/Library/Application Support/duck/Volumes/*****/*****`
 - windows
   - ネットワークドライブとしてマウントされる

