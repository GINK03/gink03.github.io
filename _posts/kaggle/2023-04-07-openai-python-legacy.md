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

## GPT3の例

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

## ChatGPTの例

```python
import openai
openai.api_key = "<api-key>"

response = openai.ChatCompletion.create(
  model="gpt-3.5-turbo",
  messages=[
        {"role": "system", "content": "You are a very helpful assistant."},
        {"role": "user", "content": "一般的に男性と女性で子供に対する姿勢が異なるかと思います。どの点が異なるのか教えて下さい。"},
        {"role": "assistant", "content": "わかりました。可能であれば参考になる情報を教えて下さい。"},
        {"role": "user", "content": 
"""以下が私の意見です。
男性の育児参加が叫ばれている昨今ですが、社会一般の風潮としてのイシューはありますが、なんらか統計的事実に基づいていないことが多いです。
男性でも女性より育児コミットしている人もいれば、典型的な女性の役割として育児をする女性もいます。
男性、女性で区別するより、個人の個別の事情に応じて何らか適切な支援をすることが大切であり、あまり男女の子供の育児に対する姿勢の違いは重要でないとの認識です。
"""
        }
    ]
)

for choice in response.choices:
    print(choice.message.role)
    print(choice.message.content)
    print()

"""
assistant
ありがとうございます。確かに、育児に関する男性と女性の姿勢については、人それぞれであるというのが現状です。一般的に、女性は子育てに情熱的であり、子どもとのコミュニケーションを重視し、愛情豊かなケアを提供することが多いと言われています。しかし、男性は子育てに参加することで、家庭内での役割分担や家族の絆を深めることができるというメリットがあります。男性は、遊びやスポーツなどアクティブで体を動かす遊び方を提供することが多く、子どもたちにとっては新鮮で楽しい体験が得られることがあります。また、男性の参加によって、子どもたちが父親との時間を大切にするようになり、父子関係の構築にもつながることがあります。したがって、男性も女性も、それぞれのスタイルで育児に関わることが大切であり、家庭や子どもたちの状況に応じた適切な支援が必要です。
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

## エンベッティングを行う

```python
import openai

openai.api_key = "<api-key>"

def get_embedding(text, model="text-embedding-ada-002"):
   text = text.replace("\n", " ")
   return openai.Embedding.create(input = [text], model=model)['data'][0]['embedding']

df['embedding'] = df["tweet_text"].apply(lambda x: get_embedding(x, model='text-embedding-ada-002'))
```

---

## 参考
 - [Chat completions](https://platform.openai.com/docs/guides/chat/chat-completions-beta)

