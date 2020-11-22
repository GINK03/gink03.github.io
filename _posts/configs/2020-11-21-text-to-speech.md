---
layout: post
title:  "text-to-speech"
date:   2020-11-21
excerpt: "text-to-speech"
project: false
config: true
tag: ["text-to-speech"]
comments: false
---

# text-to-speech

## OSXの`say`

**発音できるボイス一覧**
```console
$ say -v "?"
```

**Otoyaでの発音の例**  
```console
$ echo "こんにちは世界" | say -v "Otoya"
```

## `gtts`での発音
Googleの無料サービスにクエリを投げている？  

**gtts**  
```console
$ python3 -m pip install gTTS
```

*e.g. 話した内容をmp3形式で保存*
```python
from gtts import gTTS
tts = gTTS('今回はおすすめの本の紹介を行いたいと思います。', lang='ja')
tts.save('output.mp3')
```

## Google Cloud Text-to-Speech

wavenet等高品質モデルが使用可能である  

GRPCとAPI経由での２つでのIFが用意されている  

**google-cloud-speech**  
```console
$ python3 -m pip install google-cloud-speech
```

**APIの有効化**  
GCPの[APIとサービスの有効化](https://console.cloud.google.com/apis/dashboard)から、 `speech-to-text`のAPIを有効化している必要と`GOOGLE_APPLICATION_CREDENTIALS`の環境変数にキーが設定されているがある  

GRPCでは以下のようなコードでmp3を生成することができる  
```python
from google.cloud import texttospeech

client = texttospeech.TextToSpeechClient()
synthesis_input = texttospeech.SynthesisInput(text="こんにちは世界!")
voice = texttospeech.VoiceSelectionParams(language_code="ja-JP", name="ja-JP-Wavenet-C")
audio_config = texttospeech.AudioConfig(audio_encoding=texttospeech.AudioEncoding.MP3)
response = client.synthesize_speech(input=synthesis_input, voice=voice, audio_config=audio_config)
with open("output.mp3", "wb") as out:
    out.write(response.audio_content)
    print('Audio content written to file "output.mp3"')
```

nameでどのモデルで合成音声を作成するか指定しているが、この[リンク](https://cloud.google.com/text-to-speech/docs/voices)に`Google Cloud Text-to-Speech`の全モデルが発話例付きで列挙されている。  

## open-jtalk

ゆっくりボイスに近い音声を作りたいときに便利  

**install**

```console
$ sudo apt install open-jtalk open-jtalk-mecab-naist-jdic
```

**install voices**  
[MMDAgent_Example](https://sourceforge.net/projects/mmdagent/files/MMDAgent_Example/)のリンクから最新のzipを落とす 

`/usr/share`などに配置する  
**run example**  

```console
$ echo "そんなもうだめです" | open_jtalk -x /var/lib/mecab/dic/open-jtalk/naist-jdic -m /usr/share/hts-voice/mei/mei_happy.htsvoice -ow sample.wav
```
