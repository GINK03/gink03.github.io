---
layout: post
title: "bigquery vector search"
date: 2025-08-17
excerpt: "bigquery vector search"
tags: ["bq", "bigquery", "gcp", "bigquery", "cast"]
kaggle: true
comments: false
sort_key: "2025-08-17"
update_dates: ["2025-08-17"]
---

# bigquery vector search

## 概要
 - bigqueryに入っているベクトルデータから類似度を計算する方法

## ダミーデータのロード

```python
import pandas as pd
from google.cloud import bigquery
import pandas_gbq

# --- 1. 準備 ---
# GCPプロジェクトIDとBigQueryのデータセット・テーブルIDを設定
project_id = "your-gcp-project-id"  # ご自身のプロジェクトIDに変更してください
dataset_id = "your_dataset_id"      # 例: "vector_search_dataset"
table_id = "your_table_id"          # 例: "document_embeddings"
table_ref = f"{project_id}.{dataset_id}.{table_id}"

# --- サンプルデータ (Pandas DataFrame) の作成 ---
data = {
    'id': [1, 2, 3, 4, 5],
    'text': [
        "犬は忠実な動物です。",
        "猫は独立した動物です。",
        "犬は公園を散歩するのが好きです。",
        "猫は日向ぼっこを好みます。",
        "車は便利な乗り物です。"
    ],
    # Embeddingは float のリスト型で表現
    'embedding': [
        [0.1, 0.8, 0.2],
        [0.9, 0.2, 0.3],
        [0.2, 0.7, 0.3],
        [0.8, 0.3, 0.4],
        [0.5, 0.5, 0.9]
    ]
}
df = pd.DataFrame(data)

# --- 2. BigQueryへのデータロード ---
# BigQueryのテーブルスキーマを明示的に定義
table_schema = [
    {'name': 'id', 'type': 'INTEGER'},
    {'name': 'text', 'type': 'STRING'},
    # EmbeddingカラムをARRAY<FLOAT64>型にマッピングすることが重要
    {'name': 'embedding', 'type': 'FLOAT64', 'mode': 'REPEATED'},
]

# pandas-gbq を使ってDataFrameをBigQueryにアップロード
pandas_gbq.to_gbq(
    df,
    table_ref,
    project_id=project_id,
    if_exists='replace', # 既にテーブルがあれば上書き
    table_schema=table_schema
)
print(f"\nDataFrameをBigQueryテーブル '{table_ref}' にロードしました。")
```

## 類似度計算

```python
from google.cloud import bigquery

# BigQueryクライアント初期化
bq_client = bigquery.Client()

# クエリとパラメータ
sql_query = """
SELECT
    base.id,
    base.text,
    ML.DISTANCE(base.embedding, @query_vector, 'COSINE') AS similarity
FROM `project.dataset.table` AS base
ORDER BY similarity DESC
LIMIT 10
"""
job_config = bigquery.QueryJobConfig(
    query_parameters=[
        bigquery.ArrayQueryParameter("query_vector", "FLOAT64", query_embedding)
    ]
)

# クエリ実行
df = bq_client.query(sql_query, job_config=job_config).to_dataframe()
```
