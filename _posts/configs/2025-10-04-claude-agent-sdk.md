---
layout: post
title: "Claude Agent SDK"
date: 2025-10-04
excerpt: "Claude Agent SDK の使い方"
config: true
tag: ["claude code", "claude", "anthropic", "AI", "AIツール"]
comments: false
sort_key: "2025-10-04"
update_dates: ["2025-10-04"]
---

# Claude Agent SDK の使い方

## 概要
 - Claude Code を（Coding Agent を超えて）活用するための SDK
 - 認証方法（Amazon Bedrock や Vertex AI など）は Claude Code と同様

## インストール

```console
$ pip install claude-agent-sdk
```

## 具体例

```python
import anyio
from claude_agent_sdk import ClaudeSDKClient, ClaudeAgentOptions, AssistantMessage, TextBlock

options = ClaudeAgentOptions(
    system_prompt="あなたは優秀な開発アシスタントです。", # システムプロンプト
    allowed_tools=["Read", "Write", "Bash"],
    permission_mode="acceptEdits",
)

async def main():
    async with ClaudeSDKClient(options=options) as client:
        # 初期プロンプト（任意）
        await client.query("プロジェクトの状態を確認して")
        async for msg in client.receive_response():
            if isinstance(msg, AssistantMessage):
                for b in msg.content:
                    if isinstance(b, TextBlock):
                        print("Claude:", b.text)

        # 無限ループでユーザー入力を受け付ける
        while True:
            try:
                user_input = input("追加入力 > ").strip()
            except KeyboardInterrupt:
                print("\n[終了要求] KeyboardInterrupt 受信")
                break
            if not user_input:
                continue
            # 任意の終了コマンド
            if user_input in ("/exit", "/quit"):
                break

            # 同一セッションに追加入力
            await client.query(user_input)
            async for msg in client.receive_response():
                if isinstance(msg, AssistantMessage):
                    for b in msg.content:
                        if isinstance(b, TextBlock):
                            print("Claude:", b.text)
    # async with を抜けると自動でクリーンアップされる
anyio.run(main)
```

**CLAUDE.md を参照する例**

```python
from claude_agent_sdk import ClaudeSDKClient, ClaudeAgentOptions

options = ClaudeAgentOptions(
    system_prompt="claude_code",               # Claude Code のプリセットを使用
    setting_sources=["project"],               # カレントプロジェクトの CLAUDE.md を読み込み
    cwd="/path/to/project",                    # プロジェクトルート（省略可、プロセスの cwd でも可）
)

async with ClaudeSDKClient(options=options) as client:
    await client.query("プロジェクトのガイドラインに従って初期セットアップして")
    async for msg in client.receive_response():
        print(msg)
```
