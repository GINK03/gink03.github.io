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

```python
import os
import boto3
import pandas as pd

aws_profile = os.environ.get("AWS_PROFILE")
aws_region = os.environ.get("AWS_REGION", "ap-northeast-1")
session = (
    boto3.Session(profile_name=aws_profile, region_name=aws_region)
    if aws_profile
    else boto3.Session(region_name=aws_region)
)
bedrock_client = session.client(service_name='bedrock')

try:
    response = bedrock_client.list_foundation_models(byProvider='anthropic')
    models_data = response.get('modelSummaries', [])
    model_df = pd.DataFrame(models_data)
    print(f"取得モデル数: {len(model_df)}")
    columns = ['modelId', 'modelName', 'inputModalities', 'outputModalities', 'responseStreamingSupported']
    print(model_df[columns].to_string(index=False))
except Exception as e:
    print(f"モデル取得に失敗: {e}")
```
