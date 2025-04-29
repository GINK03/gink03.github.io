---
layout: post
title: "openai agent" 
date: 2025-04-16
excerpt: "openai agent"
kaggle: true
tag: ["openai", "agent", "mcp"]
comments: false
sort_key: "2025-04-16"
update_dates: ["2025-04-16"]
---

# openai anget


## 概要
 - openaiのagentの使い方

## インストール

```console
$ pip install openai-agents
```
 
## 基本的な使い方

```python
import asyncio
from agents import Agent, Runner

agent = Agent(name="Assistant", instructions="You are a helpful assistant")

async def main():
    result = await Runner.run(agent, "Write a haiku about recursion in programming. answer in Japanase.")
    print(result.final_output)

await main()
"""
再帰の美  
コードの中にまた  
始まりゆく
"""
```

## 状態の保存

```python
import asyncio
from agents import Agent, Runner

# エージェントの定義
agent = Agent(
    name="ChatBot",
    instructions="あなたは親切なアシスタントです。ユーザーの質問にやさしく丁寧に答えてください。",
)

chat_history = []

async def chat_with_memory(user_message):
    chat_history.append({"role": "user", "content": user_message})
    
    result = await Runner.run(agent, chat_history)
    
    chat_history.append({"role": "assistant", "content": result.final_output})
    return result.final_output

await chat_with_memory("わたしの名前はカカポです。必ず返答のときは「カカポさん〜」で始めてね")
"""
もちろんです、カカポさん。何かお手伝いできることはありますか？
"""
await chat_with_memory("お腹が空きました。どうしたらいいですか？")
"""
カカポさん、まずは軽く何か食べられるものを用意してみてはいかがでしょうか？果物やナッツ、ヨーグルトなどの軽食は簡単に用意できますよ。それとも、何か特別に食べたいものはありますか？
"""
```

## toolの定義と呼び出し

```python
import asyncio
from agents import function_tool
from agents import Agent, Runner

@function_tool
def get_weather(city: str) -> str:
    return f"The weather in {city} is sunny."

cb_agent = Agent(
    name="ChatBot",
    instructions="あなたは親切なアシスタントです。ユーザーの質問にやさしく丁寧に答えてください。",
    tools=[get_weather],
)

chat_history = []

async def chat_with_memory(user_message):
    chat_history.append({"role": "user", "content": user_message})

    result = await Runner.run(cb_agent, chat_history)

    chat_history.append({"role": "assistant", "content": result.final_output})
    return result.final_output

await chat_with_memory("今日の東京の天気を教えて")
"""
今日の東京の天気は晴れです。素敵な一日をお過ごしください！🌞
"""
```

## ハンドオフ(Agentの切り替え)

```python
from agents import Agent

history_tutor_agent = Agent(
    name="History Tutor",
    handoff_description="Specialist agent for historical questions",
    instructions="You provide assistance with historical queries. Explain important events and context clearly.",
)

math_tutor_agent = Agent(
    name="Math Tutor",
    handoff_description="Specialist agent for math questions",
    instructions="You provide help with math problems. Explain your reasoning at each step and include examples",
)

triage_agent = Agent(
    name="Triage Agent",
    instructions="You determine which agent to use based on the user's homework question",
    handoffs=[history_tutor_agent, math_tutor_agent]
)
async def main():
    result = await Runner.run(triage_agent, "織田信長について詳しく教えて")
    print(result.final_output)
await main()
"""
織田信長（1534年〜1582年）は、戦国時代の日本の大名であり、特に革新的な軍事戦略と社会改革で知られています。彼は美濃国尾張（現在の愛知県）出身で、若年時代に家督を継ぎます。

### 幼少期と台頭

信長は若い頃、「うつけ者」（愚か者）と呼ばれることもありましたが、それはむしろ彼の常識にとらわれない先見性を示すものだったと言えます。政治的な手腕と戦略家としての能力によって、徐々に勢力を拡大しました。
...
"""
```

## 参考
 - [OpenAI Agents SDK](https://openai.github.io/openai-agents-python/)
 - [openai-agents-python/examples/](https://github.com/openai/openai-agents-python/tree/main/examples)
