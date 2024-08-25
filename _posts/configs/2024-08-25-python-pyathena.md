---
layout: post
title: "python pyathena"
date: 2024-08-25
excerpt: "python pyathenaの使い方"
tags: ["python", "pyathena"]
config: true
comments: false
sort_key: "2024-08-25"
update_dates: ["2024-08-25"]
---

# python pyathenaの使い方

## 概要
 - AWS Athena に対してクエリを実行するためのライブラリ
 - BigQuery のpandas-gbqのような使い勝手を提供

## インストール

```console
$ pip install pyathena
```

## 具体的な使い方

```python
import boto3
import pandas as pd
from pyathena import connect
from pyathena.pandas.cursor import PandasCursor

# AWS セッションの設定 (必要に応じてプロファイル名を指定)
session = boto3.Session(profile_name="your-profile", region_name="ap-northeast-1")

# Athena 接続の設定
conn = connect(
    aws_access_key_id=session.get_credentials().access_key,
    aws_secret_access_key=session.get_credentials().secret_key,
    aws_session_token=session.get_credentials().token,
    region_name="ap-northeast-1",
    s3_staging_dir="s3://your-bucket/",
    schema_name="default",
    cursor_class=PandasCursor
)

# クエリの実行
query = """
select 
    *
from
    "your-database"."your-table"
where  
    timestamp >= from_iso8601_timestamp('2024-01-01T00:00:00Z') and
    user is not null
"""

# Pandas DataFrame にクエリ結果をロード
df = pd.read_sql(query, conn)
```
