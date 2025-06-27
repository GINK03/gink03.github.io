---
layout: post
title: "gemini cli"
date: 2025-06-27
excerpt: "gemini cliの使い方"
config: true
tag: ["google", "gemini", "cli", "terminal", "coding"]
comments: false
sort_key: "2025-06-27"
update_dates: ["2025-06-27"]
---

# gemini cliの使い方

## 概要
 - gemini cliはターミナルで使用可能なgemini
 - 操作感はcodex cliやclaude codeと近い

## インストール

**npm**
```console
$ npm install -g @google/gemini-cli
```

**bun**
```console
$ bun install -g @google/gemini-cli
```

## 環境変数でキーを渡す

```console
$ export GEMINI_API_KEY="your_api_key"
```

## インストラクション
 - プロジェクトルートに`GEMINI.md`を作成
