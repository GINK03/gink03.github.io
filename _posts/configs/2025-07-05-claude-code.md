---
layout: post
title: "Claude Code"
date: 2025-07-05
excerpt: "Claude Code の使い方メモ"
config: true
tag: ["claude code"]
comments: false
sort_key: "2025-07-05"
update_dates: ["2025-07-05"]
---

# Claude Code の使い方

## 概要
 - Codex CLI や Gemini CLI に近いエージェント型の CLI ツール
 - `CLAUDE.md` をプロジェクトのルートに置くと Claude Code が文脈を読み取りやすくなる
 - AWS Bedrock や GCP Model Garden で Claude のモデルをデプロイして利用できる

## インストール

**npm**

```console
$ npm install -g @anthropic-ai/claude-code
```

**bun**

```console
$ bun add -g @anthropic-ai/claude-code
```

## 実行

```console
$ claude
```

 - 選択肢で Esc で抜けられないときは Ctrl + Esc を試す

**自動許可**

```console
$ claude --dangerously-skip-permissions
```

 - 権限確認をスキップするため注意

## ヘッドレス実行

```console
$ claude -p "ミッションを実行せよ" \
  --max-turns 100 --dangerously-skip-permissions --verbose
```

**ログをストリーミング**

```console
$ claude -p "ミッションを実行せよ" \
  --max-turns 100 \
  --dangerously-skip-permissions \
  --output-format=stream-json \
  --verbose
```

## 認証
 - 認証先として `console.anthropic.com` を選択できる

## API 経由での利用

**環境変数**

```bash
export ANTHROPIC_API_KEY=sk-ant-*****
export ANTHROPIC_MODEL=sonnet # 例
```

## GCP Model Garden 経由での利用

 - Model Garden で使用したいモデルをデプロイ
 - 必要な環境変数を設定
 - 例では `claude-3-7-sonnet@20250219` を使用
 - `gcloud` コマンドで ADC を設定

**ADC の設定**

```bash
$ gcloud auth application-default login
```

**環境変数**

```bash
export CLAUDE_CODE_USE_VERTEX=1
export ANTHROPIC_VERTEX_PROJECT_ID=cosmic-bonfire-354108
export CLOUD_ML_REGION=us-east5
export ANTHROPIC_MODEL=claude-3-7-sonnet@20250219 # デプロイしたモデルを指定
```

**グローバル設定: `~/.claude/settings.json`**
```json
{
  "env": {
    "CLAUDE_CODE_USE_VERTEX": "1",
    "ANTHROPIC_VERTEX_PROJECT_ID": "cosmic-bonfire-354108",
    "CLOUD_ML_REGION": "us-east5",
    "ANTHROPIC_MODEL": "claude-sonnet-4-5@20250929"
  }
}
```

**ローカル設定: `.claude/settings.local.json`**

 - AWS Bedrock を GCP Model Garden でオーバーライドする例

```json
{
  "env": {
    "CLAUDE_CODE_USE_BEDROCK": "0",
    "CLAUDE_CODE_USE_VERTEX": "1",
    "ANTHROPIC_VERTEX_PROJECT_ID": "your-gcp-project-id",
    "CLOUD_ML_REGION": "us-east5",
    "ANTHROPIC_MODEL": "claude-3-7-sonnet@20250219"
  }
}
```
