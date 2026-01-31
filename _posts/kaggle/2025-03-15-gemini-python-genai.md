---
layout: post
title: "gemini python genai"
date: 2025-03-15
excerpt: "pythonでgenaiの使い方"
kaggle: true
tag: ["gemini", "gpt", "LLM", "python"]
comments: false
sort_key: "2025-03-15"
update_dates: ["2025-03-15"]
---

# pythonでgenaiの使い方

## 概要
- `google-generativeai` とは別のライブラリ
- `google-generativeai` より新しく、GCPのプロジェクトIDやリージョンを明示して使える

## インストール

```console
$ pip install google-genai
```

## サンプルコード集

**テキスト生成**
```python
import os
from google import genai
from google.genai import types
from IPython.display import Markdown, display

client = genai.Client(api_key=os.environ["GEMINI_API_KEY"])

response = client.models.generate_content(
    model='gemini-2.0-flash', contents='''
タイタンフォール2のストーリーを解説して
BTとジャックの友情を強調して、1000文字程度のマークダウン形式でお願い
'''
)
display(Markdown(response.text))
"""
タイタンフォール2 ストーリー解説：BTとジャックの絆
タイタンフォール2は、兵士ジャックと相棒タイタンBTの絆を描く物語
辺境の星タイフォンで、IMCとミリシアの戦いが展開される
ジャックは戦死したラストモサからBTを託され、共に任務を進める
数々の危機を乗り越え、二人の信頼は深まり、強い友情へと変わっていく
フォールド兵器の破壊に成功するが、BTは犠牲となる
BTの記憶はジャックのヘルメットに残り、物語の続きが示唆される
"""
```

**モデルの一覧**
```python
import os
import pandas as pd
from google import genai
client = genai.Client(api_key=os.environ["GEMINI_API_KEY"])
models = pd.DataFrame([dict(model) for model in client.models.list()])
display(models)
```

**ファイルのアップロード**
```python
import os
from google import genai
client = genai.Client(api_key=os.environ["GEMINI_API_KEY"])

file = client.files.upload(file='README.md')
response = client.models.generate_content(
    model='gemini-2.0-flash',
    contents=['このファイルを要約して', file]
)
```

**ツール呼び出し**
```python
def get_current_weather(location: str) -> str:
    ret = '東京: 晴れ, 名古屋: 雨, 札幌: 雪'
    return ret


response = client.models.generate_content(
    model='gemini-2.0-flash',
    contents='今の札幌の天気は？',
    config=types.GenerateContentConfig(tools=[get_current_weather]),
)

print(response.text)
"""
札幌の天気は雪です
"""
```

**トークンカウント**
```python
core_model = "gemini-2.5-pro"
client = genai.Client()
gemini_token = client.models.count_tokens(model=core_model, contents=text).total_tokens
```

**埋め込み**
```python
from google import genai
from google.genai import types

client = genai.Client()

def get_document_embedding(text: str) -> list[float]:
    response = client.models.embed_content(
        model="gemini-embedding-001",
        contents=text,
        config=types.EmbedContentConfig(
            task_type="RETRIEVAL_DOCUMENT"
        )
    )
    return response.embeddings[0].values

def get_query_embedding(text: str) -> list[float]:
    response = client.models.embed_content(
        model="gemini-embedding-001",
        contents=text,
        config=types.EmbedContentConfig(
            task_type="RETRIEVAL_QUERY"
        )
    )
    return response.embeddings[0].values

get_document_embedding("今日は良い天気ですね")
"""
[0.123, 0.456, 0.789, ...]  # 実際の値はモデルによって異なる
"""
```

**Grounding (Google Search)**
```python
from google import genai
from google.genai.types import Tool, GoogleSearch, GenerateContentConfig

client = genai.Client(vertexai=True, location="us-central1")
keyword = "生成AI 最新動向"

response = client.models.generate_content(
    model="gemini-2.5-pro",
    contents=(
        f"# 依頼\n"
        f"- 「{keyword}」について最新の情報をリサーチして詳しく教えてください\n"
        f"- 参照元URLも同時に書いてください\n"
        f"- 出力はマークダウン形式"
    ),
    config=GenerateContentConfig(
        tools=[Tool(google_search=GoogleSearch())],
        response_modalities=["TEXT"],
    ),
)
candidate = response.candidates[0]

queries = candidate.grounding_metadata.web_search_queries
domains = []
for i, chunk in enumerate(candidate.grounding_metadata.grounding_chunks):
    # web属性の中に uri, title, domain が入っています
    if chunk.web:
        domains.append(chunk.web.domain)
print(keyword, queries, domains)
```
