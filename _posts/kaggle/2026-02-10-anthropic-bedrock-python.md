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

## litellmでの利用例

```python
import litellm

response = litellm.completion(
    model="bedrock/jp.anthropic.claude-sonnet-4-5-20250929-v1:0",
    messages=[
        {"role": "user", "content": "タイタンフォール２のストーリーについて３行で説明"}
    ],
    temperature=0.0,
)
print(response.choices[0].message.content)
"""
1. **辺境民兵の新米パイロット、ジャック・クーパーが戦闘中にベテランパイロットの死により、タイタン「BT-7274」を引き継ぐ**
2. **BTと絆を深めながら、IMC（星間製造企業）の惑星破壊兵器を阻止する任務を遂行**
3. **最後はBTが自己犠牲でクーパーを救い、兵器を破壊して惑星を守る感動的な結末**
"""
```
