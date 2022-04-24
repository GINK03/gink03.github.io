---
layout: post
title: "google drive"
date: "2022-01-14"
excerpt: "google driveの仕組みと概要"
project: false
config: true
tag: ["google", "google apps", "ネットワークドライブ"]
comments: false
---

# google driveの仕組みと概要

## 概要
 - google appsのネットワークドライブ
 - S3やGCSに近い仕組みになっており通常のHDDとは異なる
   - HDDのようにして使うとAPI制限にすぐ到達する
 - ファイルが所属するディレクトリのことをparentという

## 仕組み
 - ファイルとディレクトリには名前とは別に`fileId`と呼ばれる固有のハッシュ値のようなものが存在する
 - `fileId`がつながることで木構造になりディレクトリ構造を提供している

 - `fileId1`(ディレクトリ)
   - `fileId2`(ファイル)
   - `fileId3`(ディレクトリ)
     - `fileId4`(ファイル)
     - `fileId5`(ファイル)

## URLからWebUIにアクセス
 - [google.com/drive/](https://google.com/drive/)

## 使用できるクライアント

### [(osx)Google Drive for Desktop](https://support.google.com/a/users/answer/9965580?hl=en)
 - 公式クライント
 - osxで実行すると、smbプロトコルで`/Volumes/GoogleDrive/`にマウントされる模様
 - 公式で実装されているのでCLIでアクセスしても安定している

### [(Windows)Google Drive for Windows](https://www.google.com/drive/download/)
 - 特徴
   - mac版は`/Volumes`以下に配置されるが、windows版はGoogle Driveという名前のハードディスクが作成される
   - データの管理方式はストリーミングとミラーリングがある
     - ストリーミング -> アクセス時にデータを取得
     - ミラーリング -> すべてのデータをミラーリング(HDDの消費が激しい)
   - パスの実態
      - `C:\Users\<username>\AppData\Local\Google\DriveFS`であり張り替えることは可能

### [/gdrive/](/gdrive/)
 - linux, osxで使用できるCUIクライアント

## トラブルシューティング

### たくさんのファイルの移動・削除ができない
 - mac, windowsのクライアントで操作すると極端に遅くなるので、WebUIから行う
