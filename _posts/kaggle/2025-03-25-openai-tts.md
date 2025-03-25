---
layout: post
title: "openai tts" 
date: 2025-03-25
excerpt: "openai tts"
kaggle: true
tag: ["openai", "tts", "text-to-speech"]
comments: false
sort_key: "2025-03-25"
update_dates: ["2025-03-25"]
---

# openai tts


## 概要
 - openaiにはtext-to-speechのモデルがある
 - オンラインでデモサイトでパラメータを変更して音声を生成することができる
 - `instructions`である程度、音声の特性を変更することができる
   - テンプレート以外の設定はうまく反映されない

## デモサイト
 - `https://www.openai.fm/`

## 使用例

```python
from openai import OpenAI
from IPython.display import Audio, display

client = OpenAI()

instructions="""Accent/Affect: Japanese accent; sophisticated yet friendly, clearly understandable with a charming touch of Japanese intonation.

Tone: Warm and a little snooty. Speak with pride and knowledge for the art being presented.

Pacing: Moderate, with deliberate pauses at key observations to allow listeners to appreciate details.

Emotion: knowledgeable enthusiasm; show genuine reverence and fascination for the artwork.

Personality Affect: Cultured, engaging, and refined, guiding visitors with a blend of artistic passion and welcoming charm.
"""
response = client.audio.speech.create(
    model="gpt-4o-mini-tts",
    voice="ballad",
    input="こんにちは！今日の天気はだいぶいいですね！",
    instructions=instructions
)

# 出力
output_path = "output.mp3"
response.stream_to_file(output_path)

# ブラウザ上で再生
display(Audio(output_path, autoplay=False))
```
