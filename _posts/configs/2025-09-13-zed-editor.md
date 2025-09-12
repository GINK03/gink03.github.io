---
layout: post
title: "zed editor"
date: 2025-09-13
excerpt: "zed editorの紹介と使い方について"
tag: ["zed editor","エディタ","コードエディタ","テキストエディタ"]
config: true
comments: false
sort_key: "2025-09-13-zed-editor"
update_dates: ["2025-08-23", "2025-08-24"]
---

# zed editorの紹介と使い方について

## 概要
 - Rust製のテキストエディタ。パフォーマンスが非常に高い
 - Vimライクな操作が可能
 - リアルタイム共同編集機能が標準で組み込まれている
 - BYOK (Bring Your Own Key) で好みのAI（GPT、Gemini、Claude等）を組み込める
 - GitHub Copilotも利用可能
 - LSP (Language Server Protocol) に標準対応しており、各種言語の補完や定義ジャンプが利用可能
 - ターミナルも統合されている

## インストール

```console
$ brew install zed
```

## 設定
 - `Cmd + ,` で `settings.json` を開いて編集

## 便利なショートカット
 - `Cmd + Shift + P`: コマンドパレットを開く
 - `Cmd + P`: ファイルを検索して開く
 - ``Ctrl + ` ``: ターミナルを開く
 - `Cmd + D`: 同じ単語を複数選択（マルチカーソル）

## 基本的な使い方（AI関連）
 - `Ctrl + Enter` でインラインAIアシスタントを起動
 - `Cmd + R` でサイドバーのAIアシスタントにアクセス
   - `Cmd + Alt + t` で新規にテキストチャットを開始
   - `gemini cli` や `claude code` を呼び出してコードを編集可能

## My Config

```json
{
  "vim_mode": true,
  "features": {
    "edit_prediction_provider": "copilot"
  },
  "agent": {
    "default_model": {
      "provider": "openai",
      "model": "gpt-5-nano"
    },
    "always_allow_tool_actions": true,
    "inline_assistant_model": {
      "provider": "copilot_chat",
      "model": "gpt-4.1"
    }
  },
  "ui_font_size": 16,
  "buffer_font_size": 15,
  "theme": {
    "mode": "system",
    "light": "Ayu Light",
    "dark": "Ayu Mirage"
  }
}
```
