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
 - `fileId`がつながることでディレクトリ構造を提供している

 - `fileId1`(ディレクトリ)
   - `fileId2`(ファイル)
   - `fileId3`(ディレクトリ)
     - `fileId4`(ファイル)
     - `fileId5`(ファイル)

## 使用できるクライアント

### [gdrive](/gdrive/)
 - linux, osxで使用できるCUIクライアント
