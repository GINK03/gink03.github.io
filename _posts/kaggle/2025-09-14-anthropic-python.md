---
layout: post
title: "anthropic python" 
date: 2025-09-14
excerpt: "anthropicでpythonの使い方"
kaggle: true
tag: ["AI","LLM","API","Python","Anthropic"]
comments: false
sort_key: "2025-09-14"
update_dates: ["2025-09-14"]
---

# AnthropicのPythonの使い方

## 概要
 - OpenAIのライブラリと似たインターフェース
 - max_tokensの指定が必須
 - modelはフルネームで指定する必要がある

## インストール

```console
$ pip install anthropic
```

## APIキーの設定

```python
import os

os.environ["ANTHROPIC_API_KEY"] = "sk-ant-xxxxxx"
```

## 利用可能なモデルの確認

```python
import os
import pandas as pd
from anthropic import Anthropic

client = Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])

# 自動ページネーション: 反復するだけで全件を取得
model = pd.DataFrame([dict(model) for model in client.models.list()])
model
```


## chat completion

```python
import os
from anthropic import Anthropic
from IPython.display import display, Markdown

client = Anthropic(api_key=os.environ.get("ANTHROPIC_API_KEY"))
resp = client.messages.create(
    model="claude-sonnet-4-20250514",
    max_tokens=10000, # sonnet-4の最大値は 64_000
    messages=[
        {"role": "user", "content": "タイタンフォール２のストーリーを感動が伝わるように解説して。1000文字以内でお願いします。キーワードの「Trust me.」を入れてください"}
    ],
)
display(Markdown(resp.content[0].text))
"""
『タイタンフォール2』は、パイロット・ジャック・クーパーと相棒タイタン・BT-7274の絆を描いた傑作です。

物語は、新米パイロットのクーパーが戦闘中に師匠を失い、偶然BT-7274と出会うところから始まります。BTは冷静で論理的なロボットですが、クーパーとの任務を通じて徐々に人間らしい感情を学んでいきます。

二人は敵地を駆け抜け、時には巨大な工場設備を利用したアクロバティックな戦闘を繰り広げ、時には静かな会話を交わします。BTはクーパーに戦術を教え、クーパーはBTに人間の心を教えました。ただの道具と操縦者ではなく、真の相棒として絆を深めていくのです。

物語のクライマックス、惑星を救うため、BTは究極の犠牲を選択します。別れの瞬間、BTがクーパーに告げた「Trust me.」という言葉は、二人の絆の深さを物語る最も印象的なセリフです。機械であるはずのBTが、人間以上に人間らしい献身と愛情を示したのです。

この作品の真の魅力は、SF設定の中で描かれる普遍的な友情の物語です。種族を超えた絆、互いを思いやる心、そして最後まで相手を信じ抜く気持ち。BTとクーパーの関係は、真の友情とは何かを教えてくれます。

エンディングでは希望の光も見えますが、それまでの旅路で築かれた二人の絆こそが、この物語を忘れられないものにしているのです。
"""
```
