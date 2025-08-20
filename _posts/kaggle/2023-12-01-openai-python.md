---
layout: post
title: "openai python" 
date: 2023-12-01
excerpt: "openaiでpythonの使い方"
kaggle: true
tag: ["openai", "gpt", "LLM", "python"]
comments: false
sort_key: "2023-12-01"
update_dates: ["2023-12-01"]
---

# openaiのpythonの使い方

## 概要
 - openaiのライブラリのバージョン1.0.0以降でインターフェースの大幅な変更があった
   - 以前の0.X.X系のバージョンの使い方は[/openai-python-legacy/](/openai-python-legacy/)
 - 環境変数`OPENAI_API_KEY`にAPIキーを設定しておけば、暗黙的にAPIキーを参照してくれる

## インストール

```console
$ pip install openai
```

## APIキーの設定

```python
import os

os.environ["OPENAI_API_KEY"] = "sk-xxxxxxxxxxxxxxxxxxxxxxxx"
```

## 利用可能なモデルの確認

```python
from openai import OpenAI
client = OpenAI()

models = pd.DataFrame([dict(model) for model in client.models.list()])
models["date"] = pd.to_datetime(models["created"], unit="s")
models.sort_values(by=["date"], ascending=False)
```

## embedding

```python
from openai import OpenAI
client = OpenAI()

def get_embedding(text, model="text-embedding-3-small"):
    vec = client.embeddings.create(input = [text], model=model).data[0].embedding
    return vec
```

## chat completion

```python
from openai import OpenAI
client = OpenAI()

response = client.chat.completions.create(
  model="gpt-5",
  messages=[
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "タイタンフォール２のストーリーを感動が伝わるように解説して。1000文字以内でお願いします。キーワードの「Trust me.」を入れてください"},
  ]
)

print(response.choices[0].message.content)
# => "タイタンフォール2は、無名のライフル兵ジャック・クーパーが、一機のタイタンBT-7274と出会い、戦場で“パイロット”へと成長していく物語です。師であるラティモサ隊長の最期を経て、二人はぎこちない主従から、互いを補い合う相棒へ。ドライなユーモアと厳格な「プロトコル」、そして崖を越える瞬間に放たれる一言「Trust me.」が、機械と人の間に芽生える信頼を確かなものにします。
# IMCが起動しようとする惑星破壊兵器フォールド・ウェポンを止めるため、二人は崩壊する時間の研究施設を駆け抜け、強敵たちと死闘を重ね、幾度も離れ、再び手を伸ばします。やがてBTは、任務と友情のはざまでただ一つの答えを選ぶ――プロトコル3「パイロットを守れ」。自らを犠牲にしてクーパーを生かし、巨大な力を止めるその瞬間、機械の声に確かな温度が宿るのです。
# 別れの後、ヘルメットに灯る微かな信号は、彼らの戦いが遺した希望の残光。銃声の彼方に、信じ合う心だけが響き続けます。
```

## chat completion(streaming)

```python
from openai import OpenAI
client = OpenAI()

response = client.chat.completions.create(
  model="gpt-3.5-turbo",
  messages=[
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "Who won the world series in 2020?"},
    {"role": "assistant", "content": "The Los Angeles Dodgers won the World Series in 2020."},
    {"role": "user", "content": "Where was it played?"}
  ]
  stream=True,
  n=1,
)
for chunk in response:
    if chunk.choices:
        content = chunk.choices[0].message.content 
        if content:
            print(content, end="")
            # => "The 2020 World Series was played at Globe Life Field in Arlington, Texas."
```

## 参考
 - [openai/openai-python](https://github.com/openai/openai-python/)
