---
layout: post
title: "GitHub Copilot CLI"
date: 2025-09-29
excerpt: "GitHub Copilot CLIの使い方"
project: false
config: true
tag: ["github", "copilot", "cli"]
comments: false
sort_key: "2025-09-29"
update_dates: ["2025-09-29"]
---

# GitHub Copilot CLIの使い方

## 概要
 - claude code, codex cli, gemini-cliに続くterminalで動くAIアシスタント

## インストール

**npm**
```console
$ npm install -g @github/copilot
```

**bun**
```console
$ bun install -g @github/copilot
```

## 使い方
 - **ログイン**
   - 起動後に `/login` とすると認証URLが表示されるのでブラウザでアクセス
 - **モデルの指定**
   - 環境変数で渡す
     - e.g. `COPILOT_MODEL=gpt-5 copilot`
