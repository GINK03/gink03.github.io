---
layout: post
title: "instructor litellm"
date: 2025-12-27
excerpt: "instructor litellmの使い方"
kaggle: true
tag: ["instructor", "openai", "nlp", "gemini", "llm"]
comments: false
sort_key: "2025-12-27"
update_dates: ["2025-12-27"]
---

# instructor litellmの使い方

## 概要
 - instructorをlitellm経由で使う方法
 - モデルごとの差異を吸収しつつPydanticのスキーマで構造化出力を受け取れる

## インストール

```console
$ pip install "instructor[litellm]" litellm pydantic
```

## 前提
 - 各LLMのAPIキーを環境変数に設定しておく
   - OpenAI: `OPENAI_API_KEY`
   - Gemini: `GEMINI_API_KEY`
   - Anthropic: `ANTHROPIC_API_KEY`

## 使い方

```python
import instructor
from litellm import completion
from pydantic import BaseModel, Field
from typing import List

class Persona(BaseModel):
    name: str = Field(..., description="名前")
    sex: str = Field(..., description="性別")
    age: int = Field(..., description="年齢")
    occupation: str = Field(..., description="職業")
    context: str = Field(..., description="背景情報。500文字程度")

client = instructor.from_litellm(completion)

response = client.chat.completions.create(
    model="gemini/gemini-3-pro-preview",  # または "openai/gpt-5.2", "anthropic/claude-sonnet-4-5-20250929" 等
    messages=[
        {"role": "user", "content": f"""
# ユーザのペルソナを25個作成してください
 - 名前
 - 性別
 - 年齢
 - 職業
 - 背景情報（フリーテキスト）
"""}
    ],
    response_model=List[Persona],
    reasoning_effort="high"  # ここでレベルを指定 (low, medium, high)
)

print(response)
```
