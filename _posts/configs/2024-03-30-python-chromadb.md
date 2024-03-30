---
layout: post
title: "python chromadb"
date: 2024-03-30
excerpt: "python chromadbの使い方"
project: false
config: true
tag: ["python", "chromadb"]
comments: false
sort_key: "2024-03-30"
update_dates: ["2024-03-30"]
---

# python chromadbの使い方

## 概要
 - embeddingしたテキストを保存し、L2, cosine, IP距離でテキストをクエリに検索できるデータベース
 - embeddingに外部のサービス(e.g. OpenAI)を使える
 - LangChainのバックエンドとして使用されたり、RAGとしてのユースケースが多い

## インストール

```console
$ pip install chromadb
```

## 使い方

```python
import chromadb
from chromadb.utils import embedding_functions

# ローカルclientの例, `/tmp/chromadb` に恒久化する
client = chromadb.PersistentClient(path="/tmp/chromadb", settings=chromadb.Settings(allow_reset=True))

client.reset() # データベースの中身をすべて破棄してリセット

# OpenAIのembeddingを利用する場合
openai_ef = embedding_functions.OpenAIEmbeddingFunction(
                api_key="sk-***************************",
                model_name="text-embedding-3-small"
            )
            
# embedding_function, l2距離を指定してコレクションを取得
# embedding_functionを指定しない場合は `all-MiniLM-L6-v2` が使用される
collection = client.get_or_create_collection(name="my_collection", 
                                             embedding_function=openai_ef, 
                                             metadata={"hnsw:space": "l2"} ) 

# collectionにドキュメントとメタデータを追加
collection.add(
    documents=["This is a document", "This is another document", "これはドキュメント", "これは別のドキュメント"],
    metadatas=[{"source": "my_source"}, {"source": "my_source"}, {"source": "my_source_ja"}, {"source": "my_source_ja"}],
    ids=["id1", "id2", "id3", "id4"], 
)

# コレクションに対して自然言語でクエリ(metadataでフィルタ可能)
results = collection.query(
    query_texts=["This is a query document"],
    n_results=2,
    where={"source": "my_source_ja"}
)
```

## 参考
 - [Chroma](https://docs.trychroma.com/)
