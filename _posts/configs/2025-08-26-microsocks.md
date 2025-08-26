---
layout: post
title: "microsocks"
date: 2025-08-26
excerpt: "microsocksの使い方"
config: true
tag: ["microsocks", "proxy", "socks5"]
comments: false
sort_key: "2025-08-26-microsocks"
update_dates: ["2025-08-26"]
---

# microsocksの使い方

## 概要
 - 軽量なsocks5プロキシサーバー
 - C言語で書かれており、リソース消費が少ない

## インストール

**macOS**

```console
$ brew install microsocks
```

## 起動

**認証なしで起動**

```console
$ microsocks -p 1080
```

**認証ありで起動**

```console
$ microsocks -p 1080 -u myname -P mypass 
```

**一回認証モードで起動**
 - firefoxなどの認証をサポートしないクライアントで使う場合
 - 一度認証が通れば、その後はそのIPでは認証なしで使える

```console
$ microsocks -p 1080 -1 -u myname -P mypass

# 別のターミナルで一回認証を通す
$ curl --socks5 myuser:mypass@localhost:1080 https://www.google.com
```
