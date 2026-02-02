---
layout: post
title: "ollama gpt-oss"
date: 2026-02-02
excerpt: "ollama gpt-ossの使い方"
config: true
tag: ["ollama", "gpt-oss"]
comments: false
sort_key: "2026-02-02"
update_dates: ["2026-02-02"]
---

# ollama gpt-ossの使い方

## 概要
 - showコマンドでModelfileを取得して編集するほうが安定

## Modelfileの作成

```console
$ ollama pull gpt-oss:20b
$ ollama show gpt-oss:20b --modelfile > Modelfile.base
$ cp Modelfile.base Modelfile
```

## create

```console
$ ollama create gpt-oss:custom --modelfile Modelfile
```

## run

```console
$ ollama run gpt-oss:custom
```

## litellmからの利用(python)

**会話のストリーミング**

```python
import litellm

model_name = "ollama/gpt-oss:custom"

print(f"Connecting to {model_name} via Ollama...")

response = litellm.completion(
    model=model_name,
    messages=[
            { "role": "user", "content": "雑談をしましょう 今日はとても寒いですね" }
        ],
    api_base="http://localhost:11434",
    stream=True
)

# ジェネレータとして返ってくるのでループで処理
for chunk in response:
    content = chunk.choices[0].delta.content    
    if content:
        print(content, end="", flush=True)
print()
"""
そうですね、今日は本当に寒いですね 外に出ると、吹きつける風で体がビリビリします  
ところで、今日はどんな日課を立てていらっしゃるんですか？温かい飲み物でほっとしたり、何か趣味の時間を過ごすご予定はありますか？
"""
```

**構造化出力**
```python
import litellm
from typing import List
from pydantic import BaseModel, Field

class Persona(BaseModel):
    name: str = Field(..., description="名前")
    sex: str = Field(..., description="性別")
    age: int = Field(..., description="年齢")
    occupation: str = Field(..., description="職業")

messages = [
    {"role": "user", "content": """
# ユーザのペルソナを作成してください
 - 名前
 - 性別
 - 年齢
 - 職業
"""}
]

resp = litellm.completion(
    # ollama_chatで明示的に/api/chat経由を指定
    model="ollama_chat/gpt-oss:custom",
    api_base="http://localhost:11434",
    messages=messages,
    # JSON Schema を強制
    format=Persona.model_json_schema(),
    temperature=0.1,
    max_tokens=256,
)

persona = Persona.model_validate_json(resp.choices[0].message.content)
print(persona)
"""
name='佐藤 直樹' sex='男性' age=34 occupation='フリーランスのウェブデザイナー'
"""
```
