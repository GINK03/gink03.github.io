---
layout: post
title: "sklearn vectorizer"
date: 2024-08-12
excerpt: "sklearn vectorizerの使い方"
tags: ["python3", "sklearn", "vectorizer"]
kaggle: true
comments: false
sort_key: "2024-08-12"
update_dates: ["2024-08-12"]
---

# sklearn vectorizerの使い方

## 概要
 - tf-idf, count, hashなどのvectorizerを提供
 - transformメソッドでテキストデータをスパース行列に変換

## サンプルコード

**初期化**
```python
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.feature_extraction.text import CountVectorizer

feature_num = 10000 # 特徴量(単語)の数

# tf-idf
vectorizer = TfidfVectorizer(max_features=feature_num, stop_words=None)

# count
vectorizer = CountVectorizer(max_features=feature_num, stop_words=None,)

# count(出現したかどうかのバイナリ, 高速)
vectorizer = CountVectorizer(max_features=feature_num, stop_words=None, binary=True)
```

**変換**
```python
X = vectorizer.fit_transform(["分かち書きされたテキスト1", "分かち書きされたテキスト2", ...])
```

**単語の取得**
```python
feature_names = vectorizer.get_feature_names_out() # 単語のリスト
```
