---
layout: post
title: "google apps script library"
date: 2023-06-30
excerpt: "google apps scriptのlibraryの使い方"
project: false
config: true
tag: ["gas", "google apps script", "spreadsheets"]
comments: false
sort_key: "2023-06-30"
update_dates: ["2023-06-30"]
---

# google apps scriptのlibraryの使い方

## 概要
 - 複数のgoogle sheetsで共通して利用するコードを管理する際にlibraryの機能を用いる
 - libraryは独立したapps scriptのプロジェクトと同一
 - libraryを使用する際はライブラリ名がプレフィックスになる
   - `foo_lib.bar_func()`の呼び出し方

## 任意のlibraryを作成する
 - ライブラリ用のapps scriptプロジェクトを用意
 - 何らかコードに関数を書く
 - ライブラリとして公開するための`スクリプトID`を得る
   - `プロジェクトの設定` -> `スクリプトID`で公開用のIDが得られる

## 任意のlibraryを利用する
 - 任意のapps scriptプロジェクトを作成
 - `ライブラリ`の`+`から公開した`スクリプトID`を設定する

## 参考
 - [ライブラリの概要/developers.google.com](https://developers.google.com/apps-script/guides/libraries?hl=ja)
 - [ライブラリ クイックスタート/developers.google.com](https://developers.google.com/apps-script/quickstart/library?hl=ja)

