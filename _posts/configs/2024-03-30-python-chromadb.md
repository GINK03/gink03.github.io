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
 - IDにハッシュ値を使うことで、重複を防ぐことができる

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

## 便利Class

```python
import chromadb
import hashlib
from openai import OpenAI
from chromadb.utils import embedding_functions

class ChromaManager:
    def __init__(self, db_path='chromadb'):
        self.openai_ef = embedding_functions.OpenAIEmbeddingFunction(
                organization_id=os.environ["OPENAI_ORGANIZATION"],
                api_key=os.environ["OPENAI_API_KEY"],
                model_name="text-embedding-3-small"
            )
        self.client = chromadb.PersistentClient(path=db_path, 
                            settings=chromadb.Settings(allow_reset=True))

    def get_or_create_collection(self, name):
        return self.client.get_or_create_collection(name=name,
                            embedding_function=self.openai_ef)

    def compute_hash(self, text):
        return hashlib.sha256(text.encode('utf-8')).hexdigest()

    def document_exists(self, collection_name, doc_id):
        result = self.get_or_create_collection(collection_name).get([doc_id])
        return len(result['documents']) > 0

    def insert_item(self, collection_name, text):
        collection = self.get_or_create_collection(collection_name)
        doc_id = self.compute_hash(text)
        if not self.document_exists(collection_name, doc_id):
            collection.add(
                            ids=doc_id, 
                            documents=text,
                          )
            print(f"Document '{text}' added to collection '{collection_name}' with ID '{doc_id}'.")
        else:
            print(f"Document '{text}' already exists in collection '{collection_name}' with ID '{doc_id}'.")

    def search_similar_vectors(self, collection_name, query_text, top_k=5):
        collection = self.get_or_create_collection(collection_name)
        results = collection.query(query_texts=[query_text], n_results=top_k)
        return results

    def clear_collection(self, collection_name):
        self.client.delete_collection(collection_name)

# 使用例
manager = ChromaManager(db_path='path_to_your_database_file')

# コレクションを取得または作成
manager.get_or_create_collection("collection1")
manager.get_or_create_collection("collection2")

# 例としていくつかのテキストを追加
texts = ["This is a sample text.", "Here is another example.", "This is a sample text."]
for text in texts:
    manager.insert_item("collection1", text)

# 検索用のクエリテキストを生成して検索
query_text = "Sample text for querying."
results = manager.search_similar_vectors("collection1", query_text)

# 結果を表示
for doc in results['documents'][0]:
    print("searched document", doc)

# コレクションの内容をクリア
manager.clear_collection("collection1")
```

## 参考
 - [Chroma](https://docs.trychroma.com/)
 - [Avoid duplicates inside a chroma db - Reddit](https://www.reddit.com/r/LangChain/comments/1abkaif/avoid_duplicates_inside_a_chroma_db/)
