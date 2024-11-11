---
layout: post
title: "duckdb minio(s3)"
date: 2024-11-11
excerpt: "duckdb minio(s3)の使い方"
project: false
config: true
tag: ["olap", "duckdb", "python", "minio", "s3"]
comments: false
sort_key: "2022-01-31"
update_dates: ["2022-01-31"]
---

# duckdb minio(s3)の使い方

## 概要
 - duckdbはバックエンドにminio(s3)を使うことができる

## 具体例

**データの書き込み** 
```python
import duckdb
import pandas as pd

# サンプルデータフレームの作成
df = pd.DataFrame({
    'id': [1, 2, 3],
    'name': ['Alice', 'Bob', 'Charlie'],
    'score': [85, 90, 78]
})

# MinIOへの接続情報
s3_params = {
    's3_access_key_id': 'minioadmin',
    's3_secret_access_key': 'Unchi123#$',
    's3_endpoint': 'localhost:9000',
    's3_region': 'us-east-1',
    's3_url_style': 'path'  # パススタイルの指定
}

# DuckDBの設定に接続情報を追加
con = duckdb.connect()
con.execute("INSTALL httpfs;")
con.execute("LOAD httpfs;")
con.execute(f"SET s3_endpoint = '{s3_params['s3_endpoint']}';")
con.execute(f"SET s3_access_key_id = '{s3_params['s3_access_key_id']}';")
con.execute(f"SET s3_secret_access_key = '{s3_params['s3_secret_access_key']}';")
con.execute(f"SET s3_region = '{s3_params['s3_region']}';")
con.execute("SET s3_url_style = 'path';")
con.execute("SET s3_use_ssl = false;")  # SSLを無効化


# データフレームをテーブルとして登録
con.register('df', df)

# MinIOにParquetファイルとして書き込み
con.execute("""
COPY df TO 's3://mybucket/test_data.parquet' (FORMAT PARQUET);
""")
print("データを書き込みました。")
```

**データの読み込み**
```python
# MinIOからParquetファイルを読み込み
df_from_minio = con.execute("""
SELECT * FROM 's3://mybucket/test_data.parquet';
""").df()

print(df_from_minio)
```

