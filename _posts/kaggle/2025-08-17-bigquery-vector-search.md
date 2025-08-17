---
layout: post
title: "bigquery vector search"
date: 2025-08-17
excerpt: "bigquery vector search"
tags: ["bq", "bigquery", "gcp", "vector_search", "cosine"]
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
import pandas_gbq

project_id = "your-gcp-project-id"
table_ref = "your_project.your_dataset.document_embeddings"

df = pd.DataFrame({
    "id": [1, 2, 3, 4, 5],
    "text": [
        "犬は忠実な動物です。",
        "猫は独立した動物です。",
        "犬は公園を散歩するのが好きです。",
        "猫は日向ぼっこを好みます。",
        "車は便利な乗り物です。",
    ],
    "embedding": [
        [0.1, 0.8, 0.2],
        [0.9, 0.2, 0.3],
        [0.2, 0.7, 0.3],
        [0.8, 0.3, 0.4],
        [0.5, 0.5, 0.9],
    ],
})

pandas_gbq.to_gbq(
    df,
    table_ref,
    project_id=project_id,
    if_exists="replace",
    table_schema=[
        {"name": "id", "type": "INTEGER"},
        {"name": "text", "type": "STRING"},
        {"name": "embedding", "type": "FLOAT64", "mode": "REPEATED"},
    ],
)
```

## 類似度計算

```python
from google.cloud import bigquery

# BigQueryクライアント初期化
bq_client = bigquery.Client()

# クエリとパラメータ
query_embedding = [0.1, 0.8, 0.2]  # 検索クエリのベクトル（次元はembeddingと一致させる）

sql_query = f"""
SELECT
  id,
  text,
  1.0 - ML.DISTANCE(embedding, @query_vector, 'COSINE') AS similarity  -- コサイン類似度
FROM `{table_ref}`
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
