---
layout: post
title: "huggingface japanese"
date: 2021-02-04
excerpt: "huggingfaceで日本語をハンドリングする"
kaggle: true
hide_from_post: true
tag: ["huggingface", "nlp", "python"]
comments: false
---

# huggingfaceで日本語をハンドリングする

## sentiment推論

*install*
```python
%pip install -qq transformers
%pip install torch torchvision
%pip install "fugashi[unidic-lite]" 
%pip install ipadic
```

*推論*
```python
from transformers import AutoTokenizer, AutoModelForSequenceClassification
from transformers import pipeline

tokenizer = AutoTokenizer.from_pretrained('daigo/bert-base-japanese-sentiment', use_fast=False)
classifier = pipeline('sentiment-analysis', model="daigo/bert-base-japanese-sentiment", tokenizer=tokenizer)

classifier("うほほーい、大好き♡")
>>> [{'label': 'ポジティブ', 'score': 0.9749482870101929}]

classifier('ケーキ食べ過ぎた、もうだめ。死にたい')
>>> [{'label': 'ネガティブ', 'score': 0.6267750859260559}]
```


