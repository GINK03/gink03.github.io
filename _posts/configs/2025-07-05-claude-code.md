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
 - codex cli, gemini cliに似たagentic CLIツール
 - `CLAUDE.md` ファイルをプロジェクトのルートに置くことで、claude codeがプロジェクトのコードを理解し、質問に答えたり、コードを生成したりする
 - AWSのbedrockやGCPのModel Gardenでclaudeのモデルをデプロイすれば、そこから利用可能

## インストール

**npm**
```console
$ npm install -g @anthropic-ai/claude-code
```

**bun**
```console
$ bun install -g @anthropic-ai/claude-code
```

## 実行

```console
$ claude
```

**自動許可**
```console
$ claude --dangerously-skip-permissions
```

## 認証
 - console.anthropic.comを選択可能

 
## GCPのModel Garden経由ででの利用
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
export ANTHROPIC_MODEL=claude-3-7-sonnet@20250219
```

