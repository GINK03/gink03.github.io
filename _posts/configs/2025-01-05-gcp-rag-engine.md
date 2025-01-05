---
layout: post
title: "gcp rag engine" 
date: 2025-01-05
excerpt: "gcp rag engine"
tags: ["gcp", "rag", "vertex ai"]
config: true
comments: false
sort_key: "2025-01-05"
update_dates: ["2025-01-05"]
---

# gcp rag engine

## 概要
 - vertex aiのサービスの一部にrag engineがある
 - rag engineはマネージドなRAG用のベクトル検索エンジン

## インストール

```console
$ pip install google-cloud-aiplatform
```

## 使い方

**コーパスの作成とファイルのインポート**
```python
from vertexai.preview import rag
from vertexai.preview.generative_models import GenerativeModel, Tool
import vertexai

# Create a RAG Corpus, Import Files, and Generate a response

PROJECT_ID = "cosmic-bonfire-354108"
display_name = "test_corpus"

# Initialize Vertex AI API once per session
vertexai.init(project=PROJECT_ID, location="us-central1")

# Create RagCorpus
embedding_model_config = rag.EmbeddingModelConfig(
    publisher_model="publishers/google/models/text-multilingual-embedding-002"
)

rag_corpus = rag.create_corpus(
    display_name=display_name,
    embedding_model_config=embedding_model_config,
)

# Import Files to the RagCorpus
rag.import_files(
    rag_corpus.name,
    ['gs://lipronext-rag-test/銀河鉄道の夜.txt'],
    chunk_size=512,  # Optional
    chunk_overlap=100,  # Optional
    max_embedding_requests_per_min=900,  # Optional
)
```

**検索**
```python
response = rag.retrieval_query(
    rag_resources=[
        rag.RagResource(
            rag_corpus='projects/cosmic-bonfire-354108/locations/us-central1/ragCorpora/137359788634800128',
        )
    ],
    text="死と再生",
    similarity_top_k=10,  # Optional
    # vector_distance_threshold=0.5,  # Optional
)

for c in response.contexts.contexts:
    print(c.source_uri)
    print(c.text)
    print(c.distance)
    print(c.source_display_name)
    print(c.score)
    print("=" * 20)
"""
gs://lipronext-rag-test/銀河鉄道の夜.txt
むかしのバルドラの野原に一ぴきの蝎がいて小さな虫やなんか殺してたべて生きていたんですって。するとある日いたちに見附かって食べられそうになったんですって。さそりは一生けん命遁げて遁げたけどとうとういたちに押えられそうになったわ、そのときいきなり前に井戸があってその中に落ちてしまったわ、もうどうしてもあがられないでさそりは溺れはじめたのよ。そのときさそりは斯う云ってお祈りしたというの、
　ああ、わたしはいままでいくつのものの命をとったかわからない、そしてその私がこんどいたちにとられようとしたときはあんなに一生けん命にげた。それでもとうとうこんなになってしまった。ああなんにもあてにならない。どうしてわたしはわたしのからだをだまっていたちに呉れてやらなかったろう。そしたらいたちも一日生きのびたろうに。どうか神さま。私の心をごらん下さい。こんなにむなしく命をすてずどうかこの次にはまことのみんなの幸のために私のからだをおつかい下さい。って云ったというの。そしたらいつか蝎はじぶんのからだがまっ赤なうつくしい火になって燃えてよるのやみを照らしているのを見たって。
0.3496684384006816
銀河鉄道の夜.txt
0.3496684384006816
====================
...
"""
```

**コーパスの一覧と削除**
```python
corpora = rag.list_corpora()
print(corpora)

for corpus in list(corpora):
    rag.delete_corpus(name=corpus.name)
```

## 参考
 - [RAG Engine API](https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/rag-api)
