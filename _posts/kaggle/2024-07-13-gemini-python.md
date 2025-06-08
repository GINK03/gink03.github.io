---
layout: post
title: "gemini python" 
date: 2024-07-13
excerpt: "pythonでgeminiの使い方"
kaggle: true
tag: ["gemini", "gpt", "LLM", "python"]
comments: false
sort_key: "2024-07-13"
update_dates: ["2024-07-13"]
---

# pythonでgeminiの使い方

## 概要
 - geminiの使い方をpythonでの例で説明する
 - geminiの課金設定はGoogle Cloudのプロジェクトに紐づいている
 - APIキーは `GOOGLE_API_KEY` として環境変数に設定すると自動で読み込まれる
 - APIキーの発行は [aistudio.google.com](https://aistudio.google.com/app/) から行う

## インストール

```console
$ pip install google-generativeai
```

## サンプルコード

**生成**
```python
import google.generativeai as genai
from IPython.display import display
from IPython.display import Markdown
import os
import pandas as pd

model = genai.GenerativeModel('models/gemini-2.5-pro-preview-05-06')
response = model.generate_content(
    """タイタンフォール２のストーリーについて300文字程度で要約して。名言等を添えて感動を伝わるように.
    例えば、BTの「trust me.」など
    """,
    request_options={"timeout": 600},
    generation_config=genai.types.GenerationConfig(
        temperature=0.0 # ここでtemperatureを設定
    ),
)
Markdown(response.text)
"""
タイタンフォール2の物語は、ミリシアのライフルマン、ジャック・クーパーが、戦場で相棒となるタイタンBT-7274（BT）と出会うところから始まります。IMCの惑星破壊兵器「アーク」を巡る戦いの中、当初はぎこちなかったジャックとBTの関係は、数々の死線を共に乗り越えることで、人間とAIを超えた固い絆で結ばれていきます。
BTは常にジャックを導き、時にはユーモアを交えながら励まし、そして何よりも「プロトコル3：パイロットを保護しろ」という最優先事項に従い、ジャックを守り抜こうとします。
最終決戦、BTはジャックを生かすため、自らのコアを犠牲にしてアークを破壊。その最後の瞬間にBTがジャックに託した言葉、「信じろ (Trust me.)」は、彼の絶対的な信頼と献身の象徴として、プレイヤーの胸を強く打ちます。
BTの犠牲と、残されたジャックのヘルメットに灯る微かな光は、二人の絆が決して消えないことを示唆し、深い感動と余韻を残す物語です。
"""
```

**使用可能なモデルの一覧**
```python
models = pd.DataFrame([model for model in genai.list_models()])
models
```

**トークン数のカウント**
```python
token_num = model.count_tokens("あなたはGemini？あなたにできることを5つ教えて？")
print(token_num)
```

**動画の分析**
```python
# 動画のアップロード
video_file_name = "videos/BigBuckBunny_320x180.mp4"
print(f"Uploading file...")
video_file = genai.upload_file(path=video_file_name)
print(f"Completed upload: {video_file.uri}")

# アップロードしたファイルのリスティング
for file in genai.list_files():
    print(file.display_name, file.name, file.uri, file.update_time)

# 動画の分析
prompt = "日本語でこの動画を説明してください"
model = genai.GenerativeModel(model_name="models/gemini-1.5-flash")
response = model.generate_content([prompt, video_file],
                                  request_options={"timeout": 600})
print(response.text)
"""
承知いたしました。以下に動画の説明を日本語で記述します。

この動画は、The Peach Open Movie Projectが制作した短編アニメーション「ビッグバックバニー」です。

まず、緑豊かな牧歌的な風景が広がります。木々が生い茂り、小川が流れ、草花が咲き乱れる、のどかな情景が映し出されます。そこに、太ったウサギが登場します。ウサギは、のんびりとした様子で、草むらの中を歩いたり、花をクンクンかいだりしています。その後、ウサギは大きな木を見つけ、木の根元に隠された巣穴から現れます。

このウサギは、非常に大きく、ずんぐりむっくりとした体型をしています。体毛は白く、長い耳を持っています。表情は、時に穏やかで、時に少し不機嫌な様子も見せます。

動画の後半では、ウサギは森の中で、リスやチンチラといった他の動物たちと遭遇します。リスは、ウサギをからかうような仕草を見せ、チンチラはどんぐりを抱えています。そして、ウサギは弓矢を作り、リスに矢を放とうとします。

全体を通して、動画は明るく、ユーモラスな雰囲気で、動物たちの愛らしい動きと表情が魅力的です。特に、太ったウサギのコミカルな姿は、見ている人を楽しくさせてくれます。

動画の最後にはスタッフロールが流れ、制作チームや関係者の名前が表示されます。
"""

# トークン数の見積もり
model.count_tokens([prompt, video_file])
"""
total_tokens: 175827
"""

# アップロードした動画の削除
genai.delete_file(video_file.name)
```
