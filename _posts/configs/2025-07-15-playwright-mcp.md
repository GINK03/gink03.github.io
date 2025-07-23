---
layout: post
title: "playwright mcp"
date: 2025-07-15
excerpt: "playwright mcpの使い方"
config: true
tag: ["playwright", "mcp", "python", "screenshot", "html-to-png", "asyncio", "sync"]
comments: false
sort_key: "2025-07-15"
update_dates: ["2025-07-15"]
---

# playwright mcpの使い方

## 概要
 - `Accessibility Tree` というUI要素の役割（role）や名前（ラベル）、状態、階層構造を表すツリー構造を利用してLLMにアクセスしやすくするためのツール
 - スクリーンショットを取ることも可能
 - すべての要素をツリー構造(Accessibility Tree)で表現するためかトークンの消費が激しい

## プロファイル
 - `~/.cache/ms-playwright/mcp-chrome-profile/`

## mcpの設定例

```console
"playwright": {
  "command": "npx",
  "args": [
    "@playwright/mcp@latest"
  ]
}
```

