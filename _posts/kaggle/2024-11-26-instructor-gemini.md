---
layout: post
title: "instructor gemini"
date: 2024-11-26
excerpt: "instructor geiminiの使い方"
kaggle: true
tag: ["instructor", "openai", "nlp", "gemini", "llm"]
comments: false
sort_key: "2024-11-26"
update_dates: ["2024-11-26"]
---

# instructor geminiの使い方

## 概要
 - geminiでもinstructorを使用することができる
 - `temperature`などのパラメータを指定する際はclientの初期化時に指定する

## インストール

```console
$ pip install "instructor[google-genai]"
```

## 使用例

```python
import instructor
from pydantic import BaseModel, Field


class Blog(BaseModel):
    title: str = Field(..., description="ブログのタイトル")
    body: str = Field(..., description="ブログ本文")


client = instructor.from_provider(
    "google/gemini-2.5-pro",
    mode=instructor.Mode.GENAI_STRUCTURED_OUTPUTS,
)

# As a parameter
response = client.chat.completions.create(
    system="あなたはブログ記事を構造化するアシスタント",
    messages=[{"role": "user", "content": "instructorとgeminiの使い方についてブログを書きたい"}],
    response_model=Blog,
    generation_config={
        "temperature": 0.0,
        #"max_output_tokens": 256,
        #"top_p": 1,
        #"top_k": 32,
    },
)

print(response)
```

## Vertex AI経由での使用例
 - `instructor.from_provider()` の代わりに `instructor.from_genai()` を使用する
 - 事前に `genai.Client` をVertex AI設定で初期化して渡す

```python
from google import genai
import instructor
from pydantic import BaseModel, Field
from typing import List


class <ModelName>(BaseModel):
    <field1>: str = Field(..., description="<field1の説明>")
    <field2>: str = Field(..., description="<field2の説明>")


genai_client = genai.Client(vertexai=True, location='global', project='<project-id>')

client = instructor.from_genai(
    genai_client,
    mode=instructor.Mode.GENAI_STRUCTURED_OUTPUTS,
)

response = client.chat.completions.create(
    model="gemini-2.5-flash",
    messages=[{"role": "user", "content": f"""
# 依頼
<ここにプロンプトを記述>
{text}
"""}],
    response_model=List[<ModelName>],
    generation_config={
        "temperature": 0.0,
        #"max_output_tokens": 256,
        #"top_p": 1,
        #"top_k": 32,
    },
)

print(response)
```

## 参考
 - [Instructor, The Most Popular Library for Simple Structured Outputs](https://python.useinstructor.com/)
