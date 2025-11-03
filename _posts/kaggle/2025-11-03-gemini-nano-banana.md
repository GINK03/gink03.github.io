---
layout: post
title: "gemini nano banana" 
date: 2025-11-03
excerpt: "gemini nano banana"
kaggle: true
tag: ["gemini", "gpt", "image generation", "python"]
comments: false
sort_key: "2025-11-03"
update_dates: ["2025-11-03"]
---

# gemini nano banana

## 概要
 - geminiの画像生成モデル

## 前提
 - google genaiのPython SDKを使用
 - APIキーを用意して `genai.Client` に渡す

## few-shotを利用して画像生成

```python
from google import genai
from PIL import Image
from io import BytesIO
from IPython.display import Image as Image_, display

client = genai.Client(api_key="*****")

# 参考画像を複数読み込み（スタイル学習用）
reference_image1 = Image.open("data/13544565-edd0-46c9-ada2-b6c1b068245c.png")

# スタイルを明示的に指示するプロンプト
prompt = """# 依頼
 - 桜の木の下で読書する女性を作成

## 制限
 - 画風は入力された画像を参考にして同様の画風を維持すること
 - 参考画像は複数の作例をまとめて一枚の画像にまとめている
 - 出力画像に文字を入れることは禁止
""".strip()

# 複数画像とプロンプトを渡す
response = client.models.generate_content(
    model="gemini-2.5-flash-image",
    contents=[reference_image1, prompt],
)

# 生成された画像を保存
for part in response.candidates[0].content.parts:
    if part.inline_data is not None:
        generated_image = Image.open(BytesIO(part.inline_data.data))
        generated_image.save("generated_with_style.png")
        print("スタイル適用画像を保存しました")

display(Image_("generated_with_style.png", width=320))
```
