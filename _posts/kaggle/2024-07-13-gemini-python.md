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

model = genai.GenerativeModel('gemini-1.5-pro')
response = model.generate_content("""タイタンフォール２のストーリーについて500文字程度で要約して。名言等を添えて感動を伝わるように.
例えば、BTの「trust me.」など
""")
Markdown(response.text)
"""
辺境のフロンティアで戦うミリシアのライフルマン、ジャック・クーパー。彼は、英雄になることを夢見ていた。ある日、師と仰ぐベテランパイロット、タイ・ラースから、最新鋭のヴァンガード級タイタン「BT-7274」を託される。

しかし、訓練中にIMCの襲撃を受け、タイは致命傷を負ってしまう。瀕死のタイは、自らのAIと記憶をBTに託し、ジャックに「BTを信頼しろ」と言い残す。こうして、新米パイロットと経験不足のタイタン、凸凹コンビの過酷な戦いが幕を開ける。

「プロトコル３、パイロットを守る」

幾多の戦場を共に駆け抜け、強大な敵との死闘を潜り抜ける中で、二人の間には確かな絆が生まれていく。ジャックの成長を促し、時には軽口を交わすBT。しかし、彼らの行く手には、想像を絶する過酷な運命が待ち受けていた…

「信じてくれ、ジャック」

BTの最後の言葉は、ジャックの心に深く刻まれ、フロンティアの伝説として語り継がれていく。
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
  print(file.display_name, file.name, file.uri)

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
