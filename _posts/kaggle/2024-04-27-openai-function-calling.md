---
layout: post
title: "openai function calling" 
date: 2024-04-27
excerpt: "openai function calling"
kaggle: true
tag: ["openai"]
comments: false
sort_key: "2024-04-27"
update_dates: ["2024-04-27"]
---

# openai function calling

## 概要
 - openaiのAPIを使って、関数呼び出しを行うような出力を生成するための機能
 - 関数名、引数、引数の型を指定することで、関数呼び出しのコードを生成することができる

## 具体例

```python
from openai import OpenAI
import json

client = OpenAI()

def run_conversation():
    messages = [{"role": "user", "content": "What's the weather like in San Francisco, Tokyo, and Paris?"}]
    tools = [
        {
            "type": "function",
            "function": {
                "name": "get_current_weather",
                "description": "Get the current weather in a given location",
                "parameters": {
                    "type": "object",
                    "properties": {
                        "location": {
                            "type": "string",
                            "description": "The city and state, e.g. San Francisco, CA",
                        },
                        "unit": {"type": "string", "enum": ["celsius", "fahrenheit"]},
                    },
                    "required": ["location"],
                },
            },
        }
    ]
    response = client.chat.completions.create(
        model="gpt-3.5-turbo-0125",
        messages=messages,
        tools=tools,
        tool_choice="auto",  # auto is default, but we'll be explicit
    )
    response_message = response.choices[0].message
    tool_calls = response_message.tool_calls
    for tool_call in tool_calls:
        function_name = tool_call.function.name
        function_args = json.loads(tool_call.function.arguments)
        print(function_name)
        print(function_args)

run_conversation()

"""
get_current_weather
{'location': 'San Francisco', 'unit': 'celsius'}
get_current_weather
{'location': 'Tokyo', 'unit': 'celsius'}
get_current_weather
{'location': 'Paris', 'unit': 'celsius'}
"""
```

## 参考
 - [Function calling](https://platform.openai.com/docs/guides/function-calling)
