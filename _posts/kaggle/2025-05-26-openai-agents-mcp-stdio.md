---
layout: post
title: "openai agent mcp stdio" 
date: 2025-05-26
excerpt: "openai agent mcp stdio"
kaggle: true
tag: ["openai", "agent", "workflow", "python"]
comments: false
sort_key: "2025-05-26"
update_dates: ["2025-05-26"]
---

# openai anget mcp stdio

## 概要
 - コマンドタイプ(stdioで通信するタイプ)のMCPを使用する例
 - ファイルシステムやplaywrightを使用して、ファイルの読み取りやブラウザ操作を行うことができる

## 具体例

```python
import asyncio
from contextlib import AsyncExitStack
import shutil
from agents import Agent, Runner, gen_trace_id, trace
from agents.mcp import MCPServer, MCPServerStdio
from typing import List


async def run(mcp_servers: List[MCPServer]):
    agent = Agent(
        name="Assistant",
        instructions="Use the tools to read the filesystem and answer questions based on those files in Japanese.",
        mcp_servers=mcp_servers,
    )

    message = "dataディレクトリのファイルをリストして."
    print(f"Running: {message}")
    result = await Runner.run(starting_agent=agent, input=message)
    print(result.final_output)

    next_messages = result.to_input_list() + \
        [{"role": "user", "content": "本っぽいファイルはありますか？"}]
    print(f"\n\nRunning: 本っぽいファイルはありますか？")
    result = await Runner.run(starting_agent=agent, input=next_messages)
    print(result.final_output)

    next_messages = result.to_input_list() + \
        [{"role": "user", "content": "タイトルをブラウザで `www.yahoo.co.jp` で検索してみて、結果を教えて"}]
    print(f"\n\nRunning: タイトルをブラウザで `www.yahoo.co.jp` で検索してみて、結果を教えて")
    result = await Runner.run(starting_agent=agent, input=next_messages)
    print(result.final_output)


async def main():
    servers = []
    async with AsyncExitStack() as stack:
        server = await stack.enter_async_context(
                    MCPServerStdio(
                        name="run shell, via npx",
                        params={
                            "command": "npx",
                            "args": [
                                        "-y", 
                                        "@modelcontextprotocol/server-filesystem",
                                        "."
                                    ],
                        }
                    )
                )
        servers.append(server)
        server2 = await stack.enter_async_context(
                    MCPServerStdio(
                        name="headless browser",
                        params={
                            "command": "npx",
                            "args": [
                                        "-y", 
                                        "@playwright/mcp@latest", 
                                         "--headless", 
                                         "--no-sandbox", # サンドボックスを無効化（Linux 等で必要）
                                    ],
                        }
                    )
                )
        servers.append(server2)
        trace_id = gen_trace_id()
        with trace(workflow_name="MCP Filesystem Example", trace_id=trace_id):
            print(f"View trace: https://platform.openai.com/traces/trace?trace_id={trace_id}\n")
            await run(servers)

await main()
"""
Running: dataディレクトリのファイルをリストして.
データディレクトリに含まれるファイルは次の通りです：

1. GeoLite2-ASN.mmdb
2. GeoLite2-City.mmdb
3. canva-minimalist-colorful-organizational-structure-list-graph-aVPmYwxJYMU.jpg
4. media
5. simpledic.csv
6. u1.pkl
7. u2.pkl
8. 銀河鉄道の夜.txt


Running: 本っぽいファイルはありますか？
「銀河鉄道の夜.txt」というファイルがあります。本のような内容である可能性があります。


Running: タイトルをブラウザで `www.yahoo.co.jp` で検索してみて、結果を教えて
「銀河鉄道の夜」の検索結果は以下の通りです：

1. [宮沢賢治 銀河鉄道の夜 - 青空文庫](https://www.aozora.gr.jp/cards/000081/files/456_15050.html)
2. [銀河鉄道の夜 - Wikipedia](https://ja.wikipedia.org/wiki/%E9%8A%80%E6%B2%B3%E9%89%84%E9%81%93%E3%81%AE%E5%A4%9C)
3. [Amazon.co.jp: 銀河鉄道の夜 [DVD]](https://www.amazon.co.jp/%E9%8A%80%E6%B2%B3%E9%89%84%E9%81%93%E3%81%AE%E5%A4%9C-DVD-%E7%94%B0%E4%B8%AD%E7%9C%9F%E5%BC%93/dp/B00005YWD5)

関連する情報として、「銀河鉄道の夜」の映画や歌詞についても検索結果がありました。
"""
```
