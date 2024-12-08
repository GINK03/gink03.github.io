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
$ pip install "instructor[google-generativeai]"
```

## 使用例

```python
import instructor
import google.generativeai as genai
from pydantic import BaseModel

class ExtractUser(BaseModel):
    name: str
    age: int

client = instructor.from_gemini(
    client=genai.GenerativeModel(
        model_name="models/gemini-1.5-flash-latest",
    ),
    generation_config=genai.GenerationConfig(
        #max_output_tokens=2000,
        temperature=0.2,
    ),
    mode=instructor.Mode.GEMINI_JSON,
)

# note that client.chat.completions.create will also work
resp: ExtractUser = client.messages.create(
    messages=[
        {
            "role": "user",
            "content": "Extract Jason is 25 years old.",
        }
    ],
    response_model=ExtractUser,
)

print(resp)
"""
ExtractUser(name='Jason', age=25)
"""
```

## 参考
 - [Instructor, The Most Popular Library for Simple Structured Outputs](https://python.useinstructor.com/)
