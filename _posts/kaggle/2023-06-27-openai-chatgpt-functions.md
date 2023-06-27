---
layout: post
title: "openai chatgpt functions" 
date: 2023-06-27
excerpt: "openai chatgpt functionsの使い方"
kaggle: true
tag: ["openai", "chatgpt", "functions"]
comments: false
sort_key: "2023-06-27"
update_dates: ["2023-06-27"]
---

# openai chatgpt functionsの使い方

## 概要
 - ChatGPTのリクエストに事前にfunctionsというフィールドにAPIの情報を入れておくことで質問に答える際にAPIを呼び出す出力を出せる
   - `function_call`に定義した関数名を入力するとAPIの利用を強制することができる
   - `function_call`に`"none"`を設定することでAPIを利用を全く仮定しないことができる
 - 応用することで、データベースの事前知識を入力することで、[SQLの自動生成](https://github.com/openai/openai-cookbook/blob/main/examples/How_to_call_functions_with_chat_models.ipynb)のようなことができる

## 具体例

```python
def chat_completion_request(messages, functions=None, function_call=None, model=GPT_MODEL):
    headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + openai.api_key,
    }
    json_data = {"model": model, "messages": messages}
    if functions is not None:
        json_data.update({"functions": functions})
    if function_call is not None:
        json_data.update({"function_call": function_call})
    try:
        response = requests.post(
            "https://api.openai.com/v1/chat/completions",
            headers=headers,
            json=json_data,
        )
        return response
    except Exception as e:
        print("Unable to generate ChatCompletion response")
        print(f"Exception: {e}")
        return e

functions = [
    {
        "name": "get_n_day_weather_forecast",
        "description": "Get an N-day weather forecast",
        "parameters": {
            "type": "object",
            "properties": {
                "location": {
                    "type": "string",
                    "description": "The city and state, e.g. San Francisco, CA",
                },
                "format": {
                    "type": "string",
                    "enum": ["celsius", "fahrenheit"],
                    "description": "The temperature unit to use. Infer this from the users location.",
                },
                "num_days": {
                    "type": "integer",
                    "description": "The number of days to forecast",
                }
            },
            "required": ["location", "format", "num_days"]
        },
    },
]

messages = []
messages.append({"role": "system", "content": "Don't make assumptions about what values to plug into functions. Ask for clarification if a user request is ambiguous."})
messages.append({"role": "user", "content": "Give me a weather report for Toronto, Canada."})
chat_response = chat_completion_request(
    messages, functions=functions, function_call={"name": "get_n_day_weather_forecast"}
)
chat_response.json()["choices"][0]["message"]
"""
{'role': 'assistant',
 'content': None,
 'function_call': {'name': 'get_n_day_weather_forecast',
  'arguments': '{\n  "location": "Toronto, Canada",\n  "format": "celsius",\n  "num_days": 1\n}'}}
"""
```
