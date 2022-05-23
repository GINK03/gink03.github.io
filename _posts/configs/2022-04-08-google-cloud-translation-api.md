---
layout: post
title: "gcp translation api"
date: 2022-04-08
excerpt: "gcp translation apiについて"
tags: ["nlp", "google cloud platform", "gcp", "translation", "api"]
config: true
comments: false
sort_key: "2022-04-08"
update_dates: ["2022-04-08"]
---

# gcp translation apiについて

## できること
 - 任意の言語から他の言語に翻訳する
 - Basic版と発展版がある

## Basic版による翻訳の例

### pythonによる実装

```python
from google.cloud import translate_v2 as translate

def translate_text(target, text):
    translate_client = translate.Client()

    result = translate_client.translate(text, target_language=target)

    print("Text: {}".format(result["input"]))
    print("Translation: {}".format(result["translatedText"]))
    print("Detected source language: {}".format(result["detectedSourceLanguage"]))


def main():
    translate_text("ja", "Analysis: Emmanuel Macron has a grand vision for the West. Putin has exposed the limits of his influence")
    # translate_text("hi", "Analysis: Emmanuel Macron has a grand vision for the West. Putin has exposed the limits of his influence")

if __name__ == "__main__":
    main()
```

### 出力例

```config
Text: Analysis: Emmanuel Macron has a grand vision for the West. Putin has exposed the limits of his influence
Translation: 分析：エマニュエル・マクロンは西側に対して壮大なビジョンを持っています。プーチンは彼の影響力の限界を明らかにした
Detected source language: en
```

## 参考
 - [テキストの翻訳（Basic）/Google Cloud](https://cloud.google.com/translate/docs/basic/translating-text#translating_text)
 - [テキストの翻訳（Advanced）/Google Cloud](https://cloud.google.com/translate/docs/advanced/translating-text-v3)
 - [言語サポート/Google Cloud](https://cloud.google.com/translate/docs/languages)
