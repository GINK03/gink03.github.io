---
layout: post
title: "openai fine tuned" 
date: 2025-01-12
excerpt: "openai fine tuned"
kaggle: true
tag: ["openai", "fine-tuned", "fine-tuning"]
comments: false
sort_key: "2025-01-12"
update_dates: ["2025-01-12"]
---

# openai fine tuned

## 概要
 - openaiのモデルはいくつかのモデルをfine-tunedすることができる
 - fine-tunedしたモデルは、openaiのAPIを使って利用することができる
 - ハイパーパラメータの設定項目は[openaiのapi-reference](https://platform.openai.com/docs/api-reference/fine-tuning/create)に記載されている
   - epoch, batch_size, learning_rate_multiplier などが設定可能

## ユースケース
 - Setting the style, tone, format, or other qualitative aspects
   - トンマナを変更する
 - Improving reliability at producing a desired output
   - jsonでの出力を確実にする、など  
 - Performing a new skill or task that’s hard to articulate in a prompt
   - 社内用語を使った質問に対して回答を返す、など

## fine-tuningの手順

**データセットの作成**
 - 特定のフォーマット(chatgptのchat形式のjsonl)に整形

```python
import json
import pandas as pd
from sklearn.model_selection import train_test_split

# userとassistantの対話データと仮定
df = pd.read_pickle('data.pkl')

train_df, valid_df = train_test_split(df, test_size=0.25, random_state=42)

train_fp = open('data/train_dataset.jsonl', "w")
valid_fp = open('data/valid_dateset.jsonl', 'w')
for i in train_df.index:
    messages = { "messages": [
        {"role": "system", "content": "あなたは有能なAIアシスタントです。"},
        {"role": "user", "content": train_df.at[i, "user"]},
        {"role": "assistant", "content": train_df.at[i, "assistant"]},
        ]
    }
    train_fp.write(json.dumps(messages, ensure_ascii=False) + "\n")

for i in valid_df.index:
    messages = { "messages": [
        {"role": "system", "content": "あなたは有能なAIアシスタントです。"},
        {"role": "user", "content": train_df.at[i, "user"]},
        {"role": "assistant", "content": train_df.at[i, "assistant"]},
        ]
    }
    valid_fp.write(json.dumps(messages, ensure_ascii=False) + "\n")
```

**ファイルのアップロード**

```python
import openai
client = openai.OpenAI()

def upload_file(file_name: str, purpose: str) -> str:
    with open(file_name, "rb") as file_fd:
        response = client.files.create(file=file_fd, purpose=purpose)

    # ファイルID
    print(response.id)

upload_file("./data/train_dataset.jsonl", "fine-tune")
upload_file("./data/valid_dateset.jsonl", "fine-tune")
```

**fine-tuningの実行**

```python
import openai
client = openai.OpenAI()

# jobの実行とjob idの取得
MODEL = "gpt-4o-mini-2024-07-18"

response = client.fine_tuning.jobs.create(
    training_file="file-xxxx",
    validation_file="file-xxxx",
    model=MODEL,
    suffix="recipe-ner",
)

job_id = response.id

print("Job ID:", response.id)
print("Status:", response.status)
```

**ステータスの確認**

```python
# ステータスの確認
response = client.fine_tuning.jobs.retrieve(job_id)

print("Job ID:", response.id)
print("Status:", response.status)
print("Trained Tokens:", response.trained_tokens)
```

**学習中のロスの確認**

```python
# 学習中の lossの確認
response = client.fine_tuning.jobs.list_events(job_id)

events = response.data
events.reverse()

for event in events:
    print(event.message)
```

**fine-tuningしたモデルのIDの取得**

```python
# 最終的なモデルの取得
response = client.fine_tuning.jobs.retrieve(job_id)
fine_tuned_model_id = response.fine_tuned_model

if fine_tuned_model_id is None:
    raise RuntimeError(
        "Fine-tuned model ID not found. Your job has likely not been completed yet."
    )

print("Fine-tuned model ID:", fine_tuned_model_id)
```

## 参考
 - [How to fine-tune chat models](https://cookbook.openai.com/examples/how_to_finetune_chat_models)

