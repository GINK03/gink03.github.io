---
layout: post
title: "sentence transformer"
date: 2022-06-07
excerpt: "sentence transformerの使い方"
kaggle: true
tag: ["機械学習", "transformer"]
sort_key: "2022-06-07"
update_dates: ["2022-06-07"]
comments: false
---

# sentence transformerの使い方

## 概要
 - 文章をベクトル化するトランスフォーマー
 - 直接同じ単語を使用しなくても同じような内容は近いベクトルになるなどの特徴がある

## 具体例
 - `"pickachu"`を検索クエリにして、様々な語を検索対象としたとき

```python
from sentence_transformers import SentenceTransformer
import pandas as pd

model = SentenceTransformer('sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2')

sentences0 = ["pikachu"]
embeddings0 = model.encode(sentences0)
sentences1 = ["Hentai", "Anime", "Movie", "Wife", "Wifu", "日本", "エヴァンゲリオン", "ガンダム", "superman", "captain america", "spider man", "evangelion", "pokemon", "任天堂", "nitendo"]
embeddings1 = model.encode(sentences1)

df = pd.DataFrame(list(zip(sentences1, embeddings0[0]@embeddings1.T)))
df.sort_values(by=[1], ascending=False)
```

<div align="center">
  <img style="align: center !important; width: 200px !important;" src="https://user-images.githubusercontent.com/4949982/172303133-0fdf893f-d98b-4a09-ac38-ff7c0c823c07.png">
</div>

## Google Colab
 - [sentence transformer](https://colab.research.google.com/drive/1jHEkYSs6XyVUXZqFusWi2d48JZO_P1YN?usp=sharing)

## 参考
 - [Easily get high-quality embeddings with SentenceTransformers!](https://towardsdatascience.com/easily-get-high-quality-embeddings-with-sentencetransformers-c61c0169864b)
 - [paraphrase-multilingual-MiniLM-L12-v2/huggingface](https://huggingface.co/sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2)