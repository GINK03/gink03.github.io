---
layout: post
title: "openai agent mcp" 
date: 2025-04-16
excerpt: "openai agent mcp"
kaggle: true
tag: ["openai", "agent", "mcp"]
comments: false
sort_key: "2025-04-16"
update_dates: ["2025-04-16"]
---

# openai anget mcp


## 概要
 - openaiのagentでのmcpの使い方

## インストール

```console
$ pip install openai-agents
```
 
## SSE MCPの基本的な使い方

```python
import asyncio
from agents.mcp import MCPServerSse
from agents import Agent, Runner

async def main():
    # MCPサーバーを登録
    async with MCPServerSse(params={"url":"http://localhost:8000/sse"}) as server:

    # エージェントの定義
        agent = Agent(
            name="TimeAgent",
            instructions="ユーザーが現在の時刻を尋ねたらツールを使って正確な時刻を答えてください。",
            mcp_servers=[server],
        )

        # ユーザーからの質問
        user_input = "今ニューヨークは何時？"

        # 応答生成
        result = await Runner.run(agent, user_input)
        print("エージェント:", result.final_output)

await main()
"""
エージェント: ニューヨークの現在時刻は2025年4月15日23時31分47秒です。
"""
```

## SSEのインターフェイスの確認

```python
from agents.mcp import MCPServerSse

async def show_tools():
    async with MCPServerSse(params={"url": "http://localhost:8000/sse"}) as server:
        tools = await server.list_tools()
        for tool in tools:
            print(tool.model_dump_json(indent=2))

await show_tools()
"""
{
  "name": "get_current_time",
  "description": "\n    指定された国や地域の現在時刻を返します。\n\n    country: 国名または地域名（リテラル）\n      使用可能な値:\n        - \"日本\"\n        - \"アメリカ/ニューヨーク\"\n        - \"イギリス\"\n        - \"ドイツ\"\n        - \"インド\"\n        - \"中国\"\n        - \"ブラジル\"\n    ",
  "inputSchema": {
    "properties": {
      "country": {
        "default": "日本",
        "title": "Country",
        "type": "string"
      }
    },
    "title": "get_current_timeArguments",
    "type": "object"
  }
}
"""
```
