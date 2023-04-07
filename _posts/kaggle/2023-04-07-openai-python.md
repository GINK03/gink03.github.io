---
layout: post
title: "openai python" 
date: 2023-04-07
excerpt: "openaiでpythonの使い方"
kaggle: true
tag: ["openai", "gpt", "python"]
comments: false
sort_key: "2023-04-07"
update_dates: ["2023-04-07"]
---

# openaiのpythonの使い方

## 概要
 - pythonでGPTで生成する例

## 具体例

```python
import openai
import os

openai.api_key = "<api-key>"

def generate_prompt():
    return "なにかモモという小さい女の子を主人公にして日本語の短い物語を生成してください。"


response = openai.Completion.create(
    model="text-davinci-003",
    prompt=generate_prompt(),
    temperature=0.6,
    max_tokens=300, # 戻り値の例
    n=5,
)

for choice in response.choices:
    print(choice.text)
    print()

"""
モモは小さな村に住んでいました。その村には大きな森があり、森の中には美しい花がたくさん咲いていました。モモは毎日森に行って花を見ては、その色や香りを楽しんでいました。ある日、モモは森の中で小さな小鳥を見つけました。その小鳥はモモと友達になり、それから毎日森を一緒に散歩して花を見て遊んでいました。モモは小鳥と一緒に楽しい時間を過ごしました。

モモは家族と一緒に山に登っていた。楽しい気持ちになると、モモは山を急いで降り始めた。しかし、山を降りている途中、彼女は古い古い屋敷を見つけた。そこで、モモは気になって中に入ってみることにした。中には色々な宝物が積み上げられていた。モモは一つずつ手にとって、大きな笑顔でそれらを見ていた。

モモは朝から外に出かけることを楽しみにしていました。彼女は朝日が昇る前に家を出ました。そして、大きな森を歩き始めました。森の中で、彼女は新しい友達を見つけました。友達と一緒に、森の中を散歩したり、空を見上げたり、お花畑を散策したりしました。モモはとても楽しく、朝から晩まで冒険を楽しみました。
"""
```

## モデルの一覧を確認する

```python
models = pd.DataFrame(openai.Model.list()["data"])
models
models["date"] = pd.to_datetime(models["created"], unit="s")
models.sort_values(by=["date"], ascending=False)
```

| id                            | object   |    created | owned_by        | permission                                                                                       | root                          | parent   | date                |
|:------------------------------|:---------|-----------:|:----------------|:-------------------------------------------------------------------------------------------------|:------------------------------|:---------|:--------------------|
| gpt-3.5-turbo-0301            | model    | 1677649963 | openai          | [<OpenAIObject model_permission id=modelperm-Dh9cbvU3d1LUSG2vFb8JHeBT at 0x7f6927631e40> JSON: { | gpt-3.5-turbo-0301            |          | 2023-03-01 05:52:43 |
|                               |          |            |                 |   "allow_create_engine": false,                                                                  |                               |          |                     |
|                               |          |            |                 |   "allow_fine_tuning": false,                                                                    |                               |          |

