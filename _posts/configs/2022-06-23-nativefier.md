---
layout: post
title: "nativefier"
date: 2022-06-23
excerpt: "nativefierの使い方"
tags: ["nativefier"]
config: true
comments: false
sort_key: "2022-06-23"
update_dates: ["2022-06-23"]
---

# nativefierの使い方

## 概要
 - 単一のウェブサイトを専用のアプリ化するツール
   - youtubeだけをみるブラウザを作る、みたいなイメージ
 - タブが散らかったりするのが嫌で、アプリの粒度で切り替えたい場合、便利
 - 構造的にはelectronのウェブブラウザを作成している

## インストール
 
```console
$ npm install -g nativefier
```

## 基本的な使い方

### youtube.com

```console
$ nativefier "youtube.com"  --user-agent firefox --name "youtube.com" --hide-window-frame
$ ls youtube.com-darwin-x64
LICENSE                LICENSES.chromium.html version                youtube.com.app
```

## 各オプション
 - `--user-agent`
   - useragentを設定
 - `--name`
   - 出力名
 - `--hide-window-frame`
   - windowのフレームを非表示
 - `--widevine`
   - ライセンス保護されたビデオを再生する場合
 - `--inject <filename>`
   - javascriptを埋め込んだり

## 参考
 - [github.com/nativefier/nativefier](https://github.com/nativefier/nativefier)
 - [Build Commands Catalog](https://github.com/nativefier/nativefier/blob/master/CATALOG.md)
