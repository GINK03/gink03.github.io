---
layout: post
title: "python browser use"
date: 2025-05-02
excerpt: "python browser useの使い方"
config: true
tag: ["python", "browser use", "playwright"]
comments: false
sort_key: "2025-05-02"
update_dates: ["2025-05-02"]
---

# python browser useの使い方

## 概要
 - LLMでブラウザを操作するエージェント
 - playwrightがインストールされていればheadlessで動作する

## インストール

```console
$ pip install "browser-use[memory]"
```

## サンプル

**OpenAIを利用する例**

```python
# ログの出力を無効にする
#import os
#os.environ["BROWSER_USE_LOGGING_LEVEL"] = "result" 

from IPython.display import Markdown
from browser_use import Agent
from browser_use.llm import ChatOpenAI
from browser_use.browser.browser import Browser, BrowserConfig
import asyncio


async def main():
    # ヘッドレス設定は既に済ませている前提
    browser = Browser(config=BrowserConfig(headless=True,
                                          chromium_sandbox=False))

    # タスク文字列に Markdown 指示を追加
    task = """
今日の東京の天気を教えてください。
Yahoo Japan(https://www.yahoo.co.jp/)から調べてください
出力は日本語の Markdown 形式でお願いします。
"""
    agent = Agent(
        task=task,
        llm=ChatOpenAI(model="gpt-4o"),
        browser=browser,
    )
    history = await agent.run()
    return history

history = await main()

print("=" * 80)
for step in history.history:
    for act in step.model_output.action:        # ← 0.5.x 系は action（単数）
        # DoneActionModel だけを捕捉
        if getattr(act.root, "done", None):
            display(Markdown(act.root.done.text))
print("=" * 80)
"""
=================================================================================
# 東京の天気情報
 - 日付: 2025年7月24日
 - 最高気温: 35°C
 - 最低気温: 27°C
 - 降水確率: 10%
天気情報はYahoo Japanからの提供です。
=================================================================================
"""
```

**Geminiを利用する例**

```python
from IPython.display import Markdown
from pathlib import Path
import base64
import asyncio
from dotenv import load_dotenv
from browser_use import Agent
from browser_use.llm import ChatGoogle 
from browser_use.browser.browser import Browser, BrowserConfig


async def main():
    browser = Browser(config=BrowserConfig(headless=True,
                                          chromium_sandbox=False,
                                          start_url="https://www.yahoo.co.jp"))

    task = """
    今日の東京の天気を教えてください。Yahoo Japan(https://www.yahoo.co.jp/)から調べてください
    出力は日本語の Markdown 形式でお願いします。
    """

    llm = ChatGoogle(
        model="gemini-2.5-pro",   # コスパ重視なら flash 系
        temperature=0.5,               # 必要に応じて
    )

    agent = Agent(task=task, 
                  llm=llm, 
                  browser=browser,
                  max_actions_per_step=4,)
    return await agent.run(max_steps=5)

history = await main()

# ステップごとの スクリーンショットを保存
for idx, shot in enumerate(history.screenshots()):
    if shot:
        Path(f"outputs/step_{idx:03}.png").write_bytes(base64.b64decode(shot))

print("=" * 80)
for step in history.history:
    for act in step.model_output.action:        # ← 0.5.x 系は action（単数）
        # DoneActionModel だけを捕捉
        if getattr(act, "done", None):
            display(Markdown(act.done.text))
print("=" * 80)
"""
================================================================================
# 今日の東京の天気 (7/24)
 - 天気: 曇時々晴
 - 最高気温: 35℃
 - 最低気温: 27℃
 - 降水確率: 10%
================================================================================
"""
```
