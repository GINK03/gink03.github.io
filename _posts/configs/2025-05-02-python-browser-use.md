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

```python
from langchain_openai import ChatOpenAI
from browser_use import Agent
from browser_use.browser.browser import Browser, BrowserConfig
import asyncio


async def main():
    # ヘッドレス設定は既に済ませている前提
    browser = Browser(config=BrowserConfig(headless=True))
    
    # タスク文字列に Markdown 指示を追加
    task = """
    今日の東京の天気を教えてください。
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
# history.history は各ステップ（Stepオブジェクト）のリスト
for step in history.history:
    # step.model_output.action は ActionResult のリスト
    for act in step.model_output.action:
        # act.done は DoneAction オブジェクト、done.text に生成テキスト
        if act.done:
            display(Markdown(act.done.text))
print("=" * 80)

"""
...
================================================================================
# 今日の東京の天気

今日は雨が降り、強雨や雷雨のおそれがあります。夕方から夜の帰宅の時間帯に、降り方が強まる可能性も。外出には傘が必須です。昼間は昨日ほど気温が上がりません。
================================================================================
...
"""
```
