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
from google import genai
from pydantic import BaseModel


class User(BaseModel):
    name: str
    age: int


client = instructor.from_provider("google/gemini-2.5-flash")

# As a parameter
response = client.chat.completions.create(
    system="Jason is 25 years old",
    messages=[{"role": "user", "content": "You are a data extraction assistant"}],
    response_model=User,
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
