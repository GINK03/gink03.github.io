---
layout: post
title: "openai probs" 
date: 2025-01-29
excerpt: "openai probs"
kaggle: true
tag: ["openai", "log probs"]
comments: false
sort_key: "2025-01-29"
update_dates: ["2025-01-29"]
---

# openai log probs

## 概要
 - `davinci` や `babbage` などのモデルを使って、文章の生成を行う際に、各単語の出現確率を取得可能
 - 出現確率を統計的に利用することで、perplexityの計算や、文章の自然さを評価することが可能

## 具体例

```python
import math
import numpy as np
import pandas as pd
from openai import OpenAI
client = OpenAI()

text_to_evaluate = "ここに評価したい文章をそのまま置く"


response = client.completions.create(
    model="davinci-002",   # 例: GPT-3 Ada
    prompt=text_to_evaluate,
    max_tokens=0,           # 追加生成を行わない
    temperature=0,          # 再現性のため0に
    top_p=1,
    logprobs=5,             # トークン確率の上位5件を取得(必要に応じて調整)
    echo=True               # prompt部分についてもトークン情報を取得
)

tokens = response.choices[0].logprobs.tokens
logprobs = response.choices[0].logprobs.token_logprobs

df = pd.DataFrame()
df["token"] = tokens
df["logprob"] = logprobs
df["prob"] = np.exp(df["logprob"])

ppl = df["logprob"].mean()
print(f"Perplexity: {ppl:.2f}")

display(df)
"""
Perplexity: -3.40
"""
```

| token          |      logprob |         prob |
|:---------------|-------------:|-------------:|
| こ             | nan          | nan          |
| こ             |  -3.22469    |   0.0397682  |
| に             |  -4.89034    |   0.00751887 |
| bytes:\xe8\xa9 |  -5.90883    |   0.00271538 |
| bytes:\x95     |  -4.46252    |   0.0115333  |
| 価             |  -0.175132   |   0.839347   |
| した           |  -3.5319     |   0.0292494  |
| い             |  -2.29865    |   0.100394   |
| 文章           |  -6.80772    |   0.00110521 |
| を             |  -1.22006    |   0.295212   |
| その           |  -6.56532    |   0.00140837 |
| ま             |  -0.249402   |   0.779267   |
| ま             |  -0.00761254 |   0.992416   |
| 置             |  -5.76281    |   0.00314227 |
| く             |  -2.44805    |   0.086462   |
