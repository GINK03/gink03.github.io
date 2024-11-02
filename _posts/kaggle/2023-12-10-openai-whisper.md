---
layout: post
title: "openai whisper" 
date: 2023-12-10
excerpt: "openaiでwhisperの使い方"
kaggle: true
tag: ["openai", "python", "whisper"]
comments: false
sort_key: "2023-12-10"
update_dates: ["2023-12-10"]
---

# openaiのwhisperの使い方

## 概要
 - openaiが公開しているOSSのspeech-to-textモデル
 - medium以上のウェイトは高精度
 - CPUでの推論は非常に遅い(2分の音声ファイルで10分以上かかる)
 - 単語のタイムスタンプを取得できる

## インストール

```console
$ pip install openai-whisper
```

## 使い方

```python
import whisper
# モデルのロード
model = whisper.load_model("medium")  # 'base'はモデルのサイズです。'tiny', 'small', 'medium', 'large' から選べます。

# 音声ファイルの変換
result = model.transcribe(file, language="ja", word_timestamps=True)  # 日本語指定, 単語のタイムスタンプを取得
```

## GPUのメモリのrequirement
 - [Memory requirements?](https://github.com/openai/whisper/discussions/5)

## 参考
 - [openai/whisper](https://github.com/openai/whisper)
