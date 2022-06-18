---
layout: post
title: "Sentence Transformers"
date: 2022-06-19
excerpt: "Sentence Transformersの使い方"
kaggle: true
tag: ["機械学習", "Sentence Transformers", "BERT"]
sort_key: "2022-06-19"
update_dates: ["2022-06-19"]
comments: false
---

# Sentence Transformersの使い方

## 概要
 - (BERTなどで)文章をベクトル化する
 - 各種言語でのプリトレンドモデルが公開されており、日本語のモデルもある

## プリトレンドモデルの使用例

### sbert.netのモデルの使用例

```python
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np

model = SentenceTransformer('all-mpnet-base-v2')

sentences = ['逃げちゃダメだ',
    '笑えばいいと思うよ',
    '僕は、エヴァンゲリオン初号機のパイロット、碇シンジです！',
    "あたし、にんにくラーメン、チャーシュー抜き", 
    "チャーシューラーメン大好き！"]

embeddings = model.encode(sentences)
score = cosine_similarity(embeddings) # 文章の類似度の計算
```

#### Google Colab
 - [sentence transformers](https://colab.research.google.com/drive/1m2WXlG8VzLyHw1lbwFi9ibmiqUgrnoLi?usp=sharing)

### 日本語のモデルを使用するとき
 - sbert.netの多言語モデルを用いるか、日本語で学習したモデルを用いる

#### Google Colab
 - [sentence transformers japanese](https://colab.research.google.com/drive/1TJfIm261CMCGICftIDlaCyjnsGz1bn9Y?usp=sharing)

## 参考
 - [SentenceTransformers Documentation](https://www.sbert.net/index.html)
 - [【日本語モデル付き】2020年に自然言語処理をする人にお勧めしたい文ベクトルモデル](https://qiita.com/sonoisa/items/1df94d0a98cd4f209051)

