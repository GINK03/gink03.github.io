---
layout: post
title: "Anthropic Bedrock Python"
date: 2026-02-10
excerpt: "Anthropic Bedrock Python"
kaggle: true
tag: ["AI", "LLM", "API", "Python", "Anthropic"]
comments: false
sort_key: "2026-02-10"
update_dates: ["2026-02-10"]
---

# Anthropic Bedrock Python

## 概要
 - Anthropic SDKにはAmazon Bedrock向けの`AnthropicBedrock`が用意されている

## インストール

```console
$ python -m pip install -U anthropic boto3 pandas
```

## 環境変数

```bash
AWS_REGION=ap-northeast-1
ANTHROPIC_MODEL=jp.anthropic.claude-haiku-4-5-20251001-v1:0
AWS_PROFILE=your_aws_profile_name
```

## メッセージ送信

```python
import os

from anthropic import AnthropicBedrock

client = AnthropicBedrock()
model = os.environ.get("ANTHROPIC_MODEL", "jp.anthropic.claude-haiku-4-5-20251001-v1:0")

message = client.messages.create(
    model=model,
    max_tokens=1024,
    messages=[{"role": "user", "content": "こんにちは"}]
)
print(message.content[0].text)
"""
こんにちは

何か手伝えることがあれば気軽に聞いてください
"""
```

## 利用可能なモデルの確認
 - `inferenceProfileId`が指定するモデル名に対応

```python
import boto3
import pandas as pd

client = boto3.client('bedrock', region_name='ap-northeast-1')

response = client.list_inference_profiles()

profiles = [profile for profile in response['inferenceProfileSummaries']]

df = pd.DataFrame(profiles)

df['createdAt'] = pd.to_datetime(df['createdAt'])

df = df[
    df['inferenceProfileId'].str.contains('anthropic') & 
    (df['createdAt'] >= pd.Timestamp('2025-09-01', tz='UTC'))
]

display(df)
```
