---
layout: post
title: "ubuntu pro"
date: 2022-11-19"
excerpt: "ubuntu proの概要と使い方"
tags: ["ubuntu", "linux"]
config: true
comments: false
sort_key: "2022-11-19"
update_dates: ["2022-11-19"]
---

# ubuntu proの概要と使い方

## 概要
 - ubuntuの有料サポート
   - 個人であれば、最大5個まで無料で使用できる
   - LTSのパッケージが5年が上限であるところを10年に拡大する
   - いくつかのセキュリティパッケージが追加で提供され、より安全に使用できる

## ubuntu proの使用法
 - ubuntu oneからubuntu proの個人利用を登録する
 - [ubuntu proのダッシュボード](https://ubuntu.com/pro/dashboard)からpro有効化用のトークンが表示される
 - pro有効化したいubuntuでパッケージのインストール
   - `sudo apt install ubuntu-advantage-pro` 
 - トークンでpro機能を有効化する
   - `sudo pro attach [YOUR_TOKEN]`

## 参考
 - [Ubuntu Proが個人向けにも拡大！概要から利用方法まで解説](https://and-engineer.com/articles/Y0zHixEAADssmfBB)
