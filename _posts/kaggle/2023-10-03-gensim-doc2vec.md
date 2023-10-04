---
layout: post
title: "gensim doc2vec"
date: 2023-10-03
excerpt: "gensimのdoc2vecについて"
project: false
kaggle: true
tag: ["nlp", "gensim", "doc2vec"]
comments: false
sort_key: "2023-10-03"
update_dates: ["2023-10-03"]
---

# gensimのdoc2vecについて

## 概要
 - Word2Vecをベースとした機能の拡張
 - Distributed Memory(DM)とDistributed Bag of Words(DBOW)のモデルがある
   - DM
     - 文章全体のベクトルと文中の単語ベクトルから次の単語を予測する
     - Word2VecのCBOWと似ている
   - DBOW
     - 文章全体のベクトルのみから文章内のランダムな単語を予測する
     - Word2VecのSkip-gramと似ている
 - より洗練化された手法としてbertのsentence embeddingがある
   - 計算時間の問題がbertはある

## 具体例

```python
from gensim.test.utils import common_texts
from gensim.models.doc2vec import Doc2Vec, TaggedDocument

documents = [TaggedDocument(doc, [i]) for i, doc in enumerate(common_texts)]

# DBOWがデフォルトである, パラメータはembedrankの論文を参考
model = Doc2Vec(documents, vector_size=300, window=15, min_count=5, alpha=0.025, sample=1e-5, epochs=20, workers=12)

# モデルの保存
model.save("model")

# モデルの読み込み
model = Doc2Vec.load("model")

# ベクトルの取得
model.infer_vector(["system", "response"])
```

## 参考
  - [models.doc2vec – Doc2vec paragraph embeddings](https://radimrehurek.com/gensim/models/doc2vec.html)
