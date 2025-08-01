---
layout: post
title: "gcp vertex ai embedding"
date: 2025-04-23
excerpt: "gcp vertex ai embeddingの使い方"
kaggle: true
tag: ["gcp", "vertex ai"]
sort_key: "2025-04-23"
update_dates: ["2025-04-23"]
comments: false
---

# gcp vertex ai embeddingの使い方

## 概要
 - テキストの埋め込みを生成するためのAPI
 - MRLに対応しておりあとの方の次元を削っても性能が落ちにくい
   - 次元ごとの特徴
     - 1〜256 dim: 主要テーマ
     - 257〜768 dim: 語彙・文脈の細部
     - 769 dim以降: 追加的な手がかり
   - vertex aiのエンベッティングでは768 / 1,536 / 3,072 dimが推奨

## task_type
 - `SEMANTIC_SIMILARITY`: セマンティック類似性
 - `CLASSIFICATION`: 分類タスクのための埋め込み(傾向はSEMANTIC_SIMILARITYに近い)
 - `RETRIEVAL_QUERY`: 検索クエリのための埋め込み
 - `RETRIEVAL_DOCUMENT`: 検索ドキュメントのための埋め込み

## インストール

```console
$ pip install google-cloud-aiplatform
```

## サンプルコード

**RAG (Retrieval-Augmented Generation) のためのテキスト埋め込みの生成**
```python
import vertexai
from vertexai.language_models import TextEmbeddingModel, TextEmbeddingInput

# Google CloudプロジェクトIDとリージョンを指定
PROJECT_ID = "your-project-id" # 実際のプロジェクトIDに置き換えてください
REGION = "asia-northeast1" # モデルが利用可能なリージョンを指定してください

# Vertex AI SDKの初期化
vertexai.init(project=PROJECT_ID, location=REGION)

# 使用するテキスト埋め込みモデルを指定
# 利用可能なモデルについては、Vertex AIの公式ドキュメントを参照してください。
# 例: "text-embedding-004", "text-multilingual-embedding-002"
model_name = "text-multilingual-embedding-002"

# テキスト埋め込みモデルのロード
model = TextEmbeddingModel.from_pretrained(model_name)

texts = ["これは最初のテキストです。", "そして、これが二番目のテキストです。", "関連性のある全く別の文章です。", ]

# テキストをTextEmbeddingInputオブジェクトのリストに変換
# タスクタイプを指定する場合 (例: 検索ドキュメント)
inputs = [TextEmbeddingInput(text, task_type="RETRIEVAL_DOCUMENT") for text in texts]

# テキスト埋め込みの生成
print(f"Generating embeddings for {len(texts)} texts using model: {model_name}")
embeddings = model.get_embeddings(inputs)

# 結果の表示
for i, embedding in enumerate(embeddings):
    print(f"Text: '{texts[i]}'")
    print(f"Embedding dimension: {len(embedding.values)}")
    print(f"Embedding (first 5 elements): {embedding.values[:5]}...")
    print("-" * 20)
```

**コンテンツベースのレコメンド**
```python
import vertexai, numpy as np
from vertexai.language_models import TextEmbeddingModel, TextEmbeddingInput

vertexai.init(project="your-project-id", location="asia-northeast1")
model = TextEmbeddingModel.from_pretrained("gemini-embedding-001")

texts = [
    "抹茶ラテの作り方",
    "グリーンティーラテの簡単レシピ",
    "サッカー最新戦術の解説"
]

inputs = [TextEmbeddingInput(t, task_type="SEMANTIC_SIMILARITY") for t in texts]

# 768 dim に圧縮（MRL）
embs = model.get_embeddings(inputs, output_dimensionality=768)
# デフォルトの次元
# embs = model.get_embeddings(inputs,)

# 正規化はお好みで（推奨）
array = np.vstack([e.values for e in embs]).astype("float32")
array /= np.linalg.norm(array, axis=1, keepdims=True)

print(array.shape)      # (3, 768)
```

## トラブルシューティング
 - `google.api_core.exceptions.TooManyRequests: 429` エラーが発生
   - 対応
     - `IAMと管理 / 割当` から `Vertex AI API` + `Regional online prediction requests per base model per minute per region per base_model` で検索し割当を確認
     - 割当が足りない場合は、割当の増加をリクエストする
