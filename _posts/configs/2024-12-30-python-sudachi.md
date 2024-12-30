---
layout: post
title: "python sudachipy"
date: 2024-12-15
excerpt: "pythonでsudachipyを使う"
config: true
tag: ["java", "python", "sudachi", "nlp"]
comments: false
sort_key: "2024-12-15"
update_dates: ["2024-12-15"]
---

# pythonでsudachipyを使う

## 概要
 - sudachiはワークスアプリケーションズが開発した形態素解析器
 - pythonでSudachiを使うため, sudachipyがありarchivedであるが、現在も使用可能
 - 元の実装系はJavaである

## インストール

```console
$ pip install sudachipy sudachidict_full
```

## 使い方

```python
from sudachipy import tokenizer as sudachi_tokenizer
from sudachipy import dictionary

tokenizer_obj = dictionary.Dictionary(dict="full").create()

def extract_text(text):    
    # 形容詞と名詞を抽出
    terms = []
    for token in tokenizer_obj.tokenize(text, sudachi_tokenizer.Tokenizer.SplitMode.C):
        pos = token.part_of_speech()
        if pos[0] in ('名詞', '形容詞'):
            terms.append(token.surface().lower())
    return terms

assert extract_text("今日、東京駅で激辛ラーメンを食べたよ！美味しいね") == ['今日', '東京駅', '激辛ラーメン', '美味しい']
```
