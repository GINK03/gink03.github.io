---
layout: post
title: "gemini tts" 
date: 2025-05-27
excerpt: "gemini tts"
kaggle: true
tag: ["gemini", "gpt", "tts", "python"]
comments: false
sort_key: "2025-05-27"
update_dates: ["2025-05-27"]
---

# gemini tts

## 概要
 - 複数の話者の音声を生成することができる

## コード

**単一話者**
```python
from google import genai
from google.genai import types
import wave

# Set up the wave file to save the output:
def wave_file(filename, pcm, channels=1, rate=24000, sample_width=2):
    with wave.open(filename, "wb") as wf:
        wf.setnchannels(channels)
        wf.setsampwidth(sample_width)
        wf.setframerate(rate)
        wf.writeframes(pcm)

client = genai.Client()

prompt = "今日は良い天気ですね"

response = gemini_client.models.generate_content(
    model="gemini-2.5-pro-preview-tts",
    contents=prompt,
    config=types.GenerateContentConfig(
        response_modalities=["AUDIO"],
        speech_config=types.SpeechConfig(
            voice_config=types.VoiceConfig(
                prebuilt_voice_config=types.PrebuiltVoiceConfig(
                   voice_name='Puck',
                )
            )
        ),
    ),
)

data = response.candidates[0].content.parts[0].inline_data.data
file_name = "out.wav"
wave_file(file_name, data)
```

**複数話者**
```python
from google import genai
from google.genai import types
import wave

# Set up the wave file to save the output:
def wave_file(filename, pcm, channels=1, rate=24000, sample_width=2):
    with wave.open(filename, "wb") as wf:
        wf.setnchannels(channels)
        wf.setsampwidth(sample_width)
        wf.setframerate(rate)
        wf.writeframes(pcm)

client = genai.Client()

prompt = """TTS the following conversation between Joe and Jane in Japanese:
Joe: ジェーン、今日はどんな感じ？
Jane: 悪くないわね、あなたはどう？"""

response = client.models.generate_content(
    model="gemini-2.5-pro-preview-tts",
    contents=prompt,
    config=types.GenerateContentConfig(
        response_modalities=["AUDIO"],
        speech_config=types.SpeechConfig(
            multi_speaker_voice_config=types.MultiSpeakerVoiceConfig(
                speaker_voice_configs=[
                    types.SpeakerVoiceConfig(
                        speaker="Joe",
                        voice_config=types.VoiceConfig(
                            prebuilt_voice_config=types.PrebuiltVoiceConfig(
                                voice_name="Puck",
                            )
                        ),
                    ),
                    types.SpeakerVoiceConfig(
                        speaker="Jane",
                        voice_config=types.VoiceConfig(
                            prebuilt_voice_config=types.PrebuiltVoiceConfig(
                                voice_name="Zephyr",
                            )
                        ),
                    ),
                ]
            )
        ),
    ),
)

data = response.candidates[0].content.parts[0].inline_data.data
file_name = "out.wav"
wave_file(file_name, data)
```
