---
layout: post
title: "openrouter"
date: 2025-05-08
excerpt: "openrouterの使い方"
kaggle: true
tag: ["openrouter", "llm"]
sort_key: "2025-05-08"
update_dates: ["2025-05-08"]
comments: false
---

# openrouterの使い方

## 概要
 - いろいろなLLMをAPIで使えるサービス
 - サブスクリプション不要で重要課金での支払いが可能
 - 一部のモデルは無料で使える

## サンプルコード

```python
import os
from openai import OpenAI

# ① 環境変数から API キーを取得
api_key = os.getenv("OPENROUTER_API_KEY")
if api_key is None:
    raise ValueError("環境変数 OPENROUTER_API_KEY が設定されていません。")

# ② OpenRouter エンドポイントを指定してクライアントを初期化
client = OpenAI(
    base_url="https://openrouter.ai/api/v1",
    api_key=api_key,
)

# ③ 利用するモデルを指定
model = "qwen/qwen3-30b-a3b:free"
model = "google/gemma-3-27b-it:free"


# ④ チャット用のメッセージを組み立て
messages = [
    {"role": "system", "content": "あなたは親切なアシスタントです。"},
    {"role": "user",   "content": "こんにちは。あなたは誰？"},
]

# ⑤ API を叩いて応答を取得
completion = client.chat.completions.create(
    model=model,
    messages=messages,
)

# ⑥ レスポンスの表示
reply = completion.choices[0].message.content
print("アシスタントの応答：", reply)
"""
アシスタントの応答： 
こんにちは！私はGemmaです。Google DeepMindによってトレーニングされた、大規模言語モデルです。私はオープンウェイトのAIアシスタントであり、テキストと画像をインプットとして受け取り、テキストのみを出力します
"""
```

