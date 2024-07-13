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
