---
layout: post
title: "python lingua"
date: 2024-01-27
excerpt: "python linguaの使い方"
project: false
config: true
tag: ["python", "lingua", "lingua-py", "NLP", "自然言語処理"]
comments: false
sort_key: "2024-01-27"
update_dates: ["2024-01-27"]
---

# python linguaの使い方

## 概要
 - linguaは自然言語処理でテキストがどの言語で書かれているかを判定するライブラリ
 - 精度が高いとされている
 - 一般的に言語判断は3-gramを用いて行われるが、linguaは1 ~ 5-gramを用いる
 - linguaはさらにルールベースのアプローチを用いている

## インストール

```console
$ pip install lingua-language-detector
```

## 使用例

```python
from lingua import Language, LanguageDetectorBuilder

detector = LanguageDetectorBuilder.from_all_languages().build()

# 最も確率の高い言語を返す
language = detector.detect_language_of("languages are awesome")
assert language == Language.ENGLISH

# 推定される言語とその確率を返す
confidence_values = detector.compute_language_confidence_values("最近すごい寒い")
for confidence in confidence_values:
    print(f"{confidence.language.name}: {confidence.value:.2f}")
"""
JAPANESE: 1.00
AFRIKAANS: 0.00
ALBANIAN: 0.00
ARABIC: 0.00
ARMENIAN: 0.00
AZERBAIJANI: 0.00
BASQUE: 0.00
...
"""
```

## 参考
 - [pemistahl/lingua-py - GitHub](https://github.com/pemistahl/lingua-py)
