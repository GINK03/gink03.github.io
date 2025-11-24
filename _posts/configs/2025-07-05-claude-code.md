---
layout: post
title: "claude code"
date: 2025-07-05
excerpt: "claude codeの使い方"
config: true
tag: ["claude code"]
comments: false
sort_key: "2025-07-05"
update_dates: ["2025-07-05"]
---

# claude codeの使い方

## 概要
 - Codex CLI、Gemini CLIに似たエージェント型のCLIツール
 - `CLAUDE.md` ファイルをプロジェクトのルートに置くことで、claude codeがプロジェクトのコードを理解し、質問に答えたり、コードを生成したりする
 - AWSのBedrockやGCPのModel GardenでClaudeのモデルをデプロイすれば、そこから利用可能

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

**自動許可**
```console
$ claude --dangerously-skip-permissions
```

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
 - 認証先として console.anthropic.com を選択可能

## API経由での利用

**環境変数**
```bash
export ANTHROPIC_API_KEY=sk-ant-*****
export ANTHROPIC_MODEL=sonnet # 自動でsonnetの最新バージョンを使用
```

## GCPのModel Garden経由での利用
 - Model Gardenで使用したいモデルをデプロイ
   - デプロイだけでは課金されない
 - 必要な環境変数を設定 
   - 例では `claude-3-7-sonnet@20250219` を使用
 - gcloudコマンドでADCを設定

**環境変数**
```bash
export CLAUDE_CODE_USE_VERTEX=1
export ANTHROPIC_VERTEX_PROJECT_ID=cosmic-bonfire-354108
export CLOUD_ML_REGION=us-east5
export ANTHROPIC_MODEL=claude-3-7-sonnet@20250219 # デプロイしたモデルを指定
```

**~/.claude/settings.json**
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
