---
layout: post
title: "gemini python genai" 
date: 2025-03-15
excerpt: "pythonでgenaiの使い方"
kaggle: true
tag: ["gemini", "gpt", "LLM", "python"]
comments: false
sort_key: "2025-03-15"
update_dates: ["2025-03-15"]
---

# pythonでgenaiの使い方

## 概要
 - `google-generativeai` とは別のライブラリ
 - `google-generativeai` より新しく、GCPのプロジェクトやリージョンの設定を行うことができる

## インストール

```console
$ pip install google-genai
```

## サンプルコード

**テキスト生成**
```python
from google import genai
from google.genai import types

client = genai.Client(api_key='GEMINI_API_KEY')

response = client.models.generate_content(
    model='gemini-2.0-flash', contents='''
タイタンフォール２のストーリーを解説して。
BTとジャックの友情を強調して、1000文字程度のマークダウン形式でお願い。
'''
)
display(Markdown(response.text))
"""
タイタンフォール2 ストーリー解説：BTとジャックの絆
タイタンフォール2は、一兵士ジャック・クーパーと、彼の乗機となるタイタン、BT-7274の絆を描く物語です。辺境の星タイフォンを舞台に、IMC（星間製造公社）と、その支配からの解放を目指すミリシアとの戦いが繰り広げられます。

パイロットになることを夢見るライフルマン、ジャックは、熟練パイロットのラスト・パイロットであるタイ・ラストモサの指導を受けます。しかし、タイフォンでの戦闘中、ラストモサは戦死。瀕死のラストモサは、ジャックに自身のタイタン、BT-7274の操縦権を託します。

BTは、高度なAIを搭載したヴァンガード級タイタン。当初はプロトコルに従い、ジャックをパイロットとして認識しますが、共に困難を乗り越える中で、その関係は変化していきます。IMCが開発した超兵器「フォールド兵器」の破壊を目指す中、二人は様々な危機に直面します。

惑星の自然災害、IMCの精鋭部隊、そして狡猾な傭兵集団「エイペックスプレデターズ」との戦いを通して、BTはジャックの判断を尊重し、時には自らの命を顧みず彼を守ります。ジャックもまた、BTの能力を最大限に引き出し、互いに信頼を深めていきます。

特に印象的なのは、BTがジャックを安全な場所へ送り出すために、自らを犠牲にする場面です。幾度となく訪れる別れの危機を乗り越え、二人の間に芽生えた友情は、単なる機械と人間の関係を超越した、深い絆として描かれています。

最終的に、ジャックとBTはフォールド兵器の破壊に成功し、IMCの野望を阻止します。しかし、その代償としてBTは破壊されてしまいます。物語の終わりに、BTは自身の記憶をジャックのヘルメットにアップロードしており、二人の物語はまだ終わっていないことを示唆します。

タイタンフォール2は、アクションシューティングとしての面白さはもちろん、AIと人間の友情、自己犠牲、そして希望を描いた感動的な物語です。BTとジャックの絆は、多くのプレイヤーの心を掴み、忘れられない記憶として刻まれています。
"""
```

**ファイルのアップロード**
```python
file = client.files.upload(file='README.md')
response = client.models.generate_content(
    model='gemini-2.0-flash',
    contents=['このファイルを要約して', file]
)
```

**tool call**
```python
def get_current_weather(location: str) -> str:
    ret = '東京: 晴れ, 名古屋: 雨, 札幌: 雪'
    return ret


response = client.models.generate_content(
    model='gemini-2.0-flash',
    contents='今の札幌の天気は？',
    config=types.GenerateContentConfig(tools=[get_current_weather]),
)

print(response.text)
"""
札幌の天気は雪です。
"""
```

