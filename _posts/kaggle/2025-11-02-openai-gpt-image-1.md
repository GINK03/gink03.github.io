---
layout: post
title: "openai gpt-image-1" 
date: 2025-11-02
excerpt: "openai gpt-image-1の使い方"
kaggle: true
tag: ["openai", "gpt", "LLM", "python"]
comments: false
sort_key: "2025-11-02"
update_dates: ["2025-11-02"]
---

# openai gpt-image-1の使い方

## 概要
 - OpenAIの画像生成モデル「gpt-image-1」の使い方

## 前提
 - Python OpenAI SDK v1系を使用
 - 環境変数 `OPENAI_API_KEY` を設定済み

## 基礎的な使用例

```python
from IPython.display import Image, display
from openai import OpenAI
import base64

# OpenAIクライアントを初期化
client = OpenAI()

# ユーザーからプロンプトを入力
prompt = "美しい桜の木の下で読書する猫 水彩画風"

print("画像を生成中...")

# 画像生成リクエストを送信
img = client.images.generate(
    model="gpt-image-1",
    prompt=prompt,
    background="auto",
    n=1,
    quality="low",
    size="1024x1024",
    output_format="png",
    moderation="auto"
)

# 画像をファイルに保存
image_bytes = base64.b64decode(img.data[0].b64_json)
with open("output.png", "wb") as f:
    f.write(image_bytes)

print("画像が正常に生成されました!")
display(Image("output.png", width=320))
```

## few-shot学習の例

```python
# ユーザーからプロンプトを入力
prompt = """
# 依頼
 - 桜の木の下で読書する女性を作成

## 制限
 - 画風は入力された画像を参考にして同様の画風を維持すること
 - 参考画像は複数の作例をまとめて一枚の画像にまとめている
 - 出力画像に文字を入れることは禁止
""".strip()

print("画像を生成中...")


# 画像生成リクエストを送信
img = client.images.edit(
    model="gpt-image-1",
    prompt=prompt,
    background="auto",
    n=1,
    image=[open("data/13544565-edd0-46c9-ada2-b6c1b068245c.png", "rb")],
    quality="medium", # low, medium, high
    size="1024x1024",
    output_format="png",
)

# 画像をファイルに保存
image_bytes = base64.b64decode(img.data[0].b64_json)
with open("output.png", "wb") as f:
    f.write(image_bytes)

print("画像が正常に生成されました!")
display(Image("output.png", width=320))
```
