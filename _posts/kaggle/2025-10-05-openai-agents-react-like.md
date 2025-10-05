---
layout: post
title: "OpenAI Agents React-like"
date: 2025-10-05
excerpt: "OpenAI Agents の React-like 実装"
kaggle: true
tag: ["openai", "agent", "react"]
comments: false
sort_key: "2025-10-05"
update_dates: ["2025-10-05"]
---

# OpenAI Agents React-like


## 概要
 - OpenAI Agents を使用した React-like な実装
 - シェルスクリプトの任意実行機能を追加することで、より柔軟な操作が可能

## 実装

**エージェントの定義**
```python
# pip install openai-agents
import os, re, shlex, subprocess
from agents import Agent, Runner, function_tool

# シェル実行ツール（安全のため簡易ホワイトリスト）
@function_tool
def run_shell(command: str) -> str:
    """
    Run a safe subset of shell commands and return stdout/stderr.
    Allowed: echo/printf/tee/cat, redirection to output.md in CWD.
    """
    allowed = re.compile(r"^(echo|printf|cat|tee)\b")
    if not allowed.match(command.strip()):
        return "Rejected: only echo/printf/cat/tee are allowed."
    if "rm" in command or "sudo" in command or ">/" in command.replace(">>", ">"):
        return "Rejected: dangerous tokens are not allowed."
    # 宛先ファイルは output.md のみ許可
    if "output.md" not in command:
        return "Rejected: only output.md is permitted as the write target."

    try:
        # bash -lc でパイプやリダイレクトも解釈
        cp = subprocess.run(
            ["bash", "-lc", command],
            capture_output=True, text=True, timeout=10
        )
        out = cp.stdout.strip()
        err = cp.stderr.strip()
        code = cp.returncode
        return f"[exit={code}] stdout:\n{out}\n\nstderr:\n{err}"
    except subprocess.TimeoutExpired:
        return "Timed out"
    except Exception as e:
        return f"Exception: {e}"

# エージェント：俳句を作成し、必ずシェルで output.md へ保存
agent = Agent(
    name="HaikuShellAgent",
    instructions=(
        "日本語の季語を使って 5-7-5 の俳句を 1 つ作成する。"
        "次に run_shell でシェルコマンドを呼び出し、俳句を output.md に UTF-8 で書き込む（printf や echo を用いる）。"
        "その後、必要なら run_shell('cat output.md') で内容を確認し、最終的な応答は『保存完了』と短く述べる。"
        "破壊的操作や sudo は一切行わない。"
    ),
    tools=[run_shell],
    model="gpt-5"
)
```

**エージェントの実行**
```python
# すでに agent が定義済みと仮定
result = Runner.run_streamed(
    agent,
    input="秋の情景を詠んだ俳句を生成して、シェルコマンドで output.md に保存して。すでに何か書かれている場合は、--- で区切って追記して。",
    max_turns=8,
)

from openai.types.responses import ResponseTextDeltaEvent

print("=== streaming start ===")
async for event in result.stream_events():
    # 1) LLMのトークン増分（生のレスポンス）
    if event.type == "raw_response_event" and isinstance(event.data, ResponseTextDeltaEvent):
        print(event.data.delta, end="", flush=True)
    # 2) 重要イベント（メッセージ生成・ツール開始/結果・ハンドオフ）
    elif event.type == "run_item_stream_event":
        name = getattr(event, "name", "")
        item = getattr(event, "item", None)
        if name == "tool_called":
            print("\n[tool_called]", getattr(item, "tool_name", "tool"))
        elif name == "tool_output":
            print("\n[tool_output]", getattr(item, "output", "")[:400])
        elif name == "message_output_created":
            from agents import ItemHelpers
            print("\n[message_output]\n", ItemHelpers.text_message_output(item))
    # 3) エージェントの切り替え（ハンドオフ）
    elif event.type == "agent_updated_stream_event":
        print(f"\n[agent_updated] {event.new_agent.name}")
print("\n=== streaming done ===")

print("Final:", result.final_output)
```
