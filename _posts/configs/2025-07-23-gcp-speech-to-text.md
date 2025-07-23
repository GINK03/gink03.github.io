---
layout: post
title: "gcp speech-to-text" 
date: 2025-07-23
excerpt: "gcp speech-to-text の使い方"
tags: ["gcp", "speech-to-text", "音声認識"]
config: true
comments: false
sort_key: "2025-07-23-gcp-speech-to-text"
update_dates: ["2025-07-23"]
---

# gcp speech-to-text の使い方

## 概要
 - モデルベースの音声認識サービスで、diarization（話者分離）や音声の自動文字起こしが可能
   - diarizationは2025年7月時点で日本語に対応していないが、英語や他の言語では利用可能
 - 10MBを超える音声ファイルは、Cloud Storageにアップロードしてから認識する

## インストール

```console
$ pip install google-cloud-speech
```

## サンプルコード

```python
from google.cloud import speech_v1p1beta1 as speech
from google.api_core.operation import Operation

client = speech.SpeechClient()

audio = speech.RecognitionAudio(uri=f"gs://.../.../sample.wav")

# diarizationのサポート状況
#  - https://cloud.google.com/speech-to-text/docs/speech-to-text-supported-languages?hl=ja
#  - 2025-07現在、ja-JPは未対応（なので全部同じ話者になる）
diarization_config = speech.SpeakerDiarizationConfig(
    enable_speaker_diarization=True,
    min_speaker_count=2,
    max_speaker_count=2, # min, maxの差は小さく
)

config = speech.RecognitionConfig(
    encoding=speech.RecognitionConfig.AudioEncoding.LINEAR16,
    sample_rate_hertz=16000, # 入力した音声と一致している必要がある
    audio_channel_count=2, # 話者分離を目的にする場合、オーディオのチャンネルは2がいいらしい
    language_code="ja-JP",
    diarization_config=diarization_config,
    enable_automatic_punctuation=True,
    model="latest_long",
)

print("Submitting long‑running job…")
op: Operation = client.long_running_recognize(config=config, audio=audio)

response = op.result(timeout=1800)  # 30 分まで待機

# まとめているのは最後の result
for word in response.results[-1].alternatives[0].words:
    print(f"{word.start_time.total_seconds():6.2f}-{word.end_time.total_seconds():6.2f} "
          f"SPK{word.speaker_tag}: {word.word}")
```

