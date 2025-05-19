---
layout: post
title: "python newspaper3kの使い方"
date: 2025-05-06
excerpt: "python newspaper3kの使い方"
config: true
tag: ["python", "newspaper3k"]
comments: false
sort_key: "2025-05-06"
update_dates: ["2025-05-06"]
---

# python newspaper3kの使い方

## 概要
 - HTMLを解析して、記事のタイトルや本文を抽出するライブラリ
   - Python Readabilityアルゴリズムというメインコンテンツを抽出するアルゴリズムを使用

## インストール

```console
$ pip install newspaper3k
```

## python readabilityのアルゴリズム
 - 余分なタグの削除
 - `<div>`, `<span>`, `<section>` などを `<p>` タグに変換
 - タグごとに100文字ごとに1ポイントを加算
 - 親ノードへのポイント加算
 - 一部のタグはマイナスポイント

## 使い方

**メインコンテンツの抽出**

```python
from newspaper import Article

url = "https://example.com/sample-article"
article = Article(url, language='ja')
article.download()
article.parse()
article.nlp()

# メインコンテンツの抽出
print(article.title)  # タイトル
print(article.text)   # 本文

# 要約の抽出
print(article.summary)  # 要約
```

**オフラインのHTMLファイルからの抽出**

```python
from newspaper import Article

html = "<html><body><h1>Sample Title</h1><p>This is a sample article.</p></body></html>"

article = Article(url='', language='ja')
article.download(input_html=html)
article.parse()
```
