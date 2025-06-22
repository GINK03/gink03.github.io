---
layout: post
title: "google agent development kit(adk)"
date: 2025-04-17
excerpt: "google agent development kit(adk)の使い方"
kaggle: true
tag: ["google", "agent", "development", "kit", "adk"]
comments: false
sort_key: "2025-04-17"
update_dates: ["2025-04-17"]
---

# google agent development kit(adk)の使い方


## 概要
 - adkは、Googleが開発したエージェントの開発キット
 - agentの簡単な構築とstreamlitのようなWebアプリケーションを簡単に作成できる
 - agentが呼び出す関数は、Pythonの関数として定義したり、mcpのようなAPIを定義することができる
 - `InMemorySessionService` を利用することで、セッションの状態をメモリに保存することができる
 - geminiを利用する際は`GOOGLE_API_KEY`を環境変数に設定する必要がある

## インストール

```console
$ pip install google-adk
```

## `.env`の設定

**Google AI Studio**
```
GOOGLE_GENAI_USE_VERTEXAI="False"
GOOGLE_API_KEY="**your_api_key**"
```

**Vertex AI**
```
GOOGLE_GENAI_USE_VERTEXAI=1
GOOGLE_CLOUD_PROJECT=<your_project_id>
GOOGLE_CLOUD_LOCATION=<your_project_location>
GOOGLE_CLOUD_STORAGE_BUCKET=<your-storage-bucket>  # Only required for deployment on Agent Engine
```

## 起動

### 開発UIの起動

```console
$ adk web --host "0.0.0.0"
```

### CLIでの起動

```console
$ adk run <path-to-directory>
```

## 簡単な例(google検索)

```python
from google.adk.agents import Agent
from google.adk.runners import Runner
from google.adk.sessions import InMemorySessionService
from google.adk.tools import google_search
from google.genai import types

APP_NAME="google_search_agent"
USER_ID="user1234"
SESSION_ID="1234"


root_agent = Agent(
    name="basic_search_agent",
    model="gemini-2.0-flash",
    description="Agent to answer questions using Google Search.",
    instruction="I can answer your questions by searching the internet. Just ask me anything!",
    # google_search is a pre-built tool which allows the agent to perform Google searches.
    tools=[google_search]
)

# Session and Runner
session_service = InMemorySessionService()
session = session_service.create_session(app_name=APP_NAME, user_id=USER_ID, session_id=SESSION_ID)
runner = Runner(agent=root_agent, app_name=APP_NAME, session_service=session_service)


# Agent Interaction
def call_agent(query):
    """
    Helper function to call the agent with a query.
    """
    content = types.Content(role='user', parts=[types.Part(text=query)])
    events = runner.run(user_id=USER_ID, session_id=SESSION_ID, new_message=content)

    for event in events:
        if event.is_final_response():
            final_response = event.content.parts[0].text
            print("Agent Response: ", final_response)

call_agent("what's the latest ai news?")
# 検索結果が返ってくる
call_agent("日本語に翻訳して")
# 翻訳結果が返ってくる
```

## 参考
 - [google.github.io/adk-docs](https://google.github.io/adk-docs/)

