---
layout: post
title: "AWS Data Wrangler"
date: 2026-02-15
excerpt: "AWS Data Wrangler（awswrangler）の使用方法"
tag: ["aws", "wrangler"]
config: true
comments: false
sort_key: "2026-02-15"
update_dates: ["2026-02-15"]
---

# AWS Data Wrangler（awswrangler）の使用方法

## 概要
 - AWS Data Wrangler（awswrangler）は AWSのログ系やデータ系サービスをPythonから扱いやすくするライブラリ

## インストール

```console
$ python -m pip install -U awswrangler
```

## 環境変数

```shell
$ export AWS_PROFILE=<profile_name>
$ export AWS_REGION=ap-northeast-1
```

## CloudWatch LogsをpandasのDataFrameに変換

```python
import awswrangler as wr
import pandas as pd
import ast

log_group = "your-log-group-name"

query = """
fields @timestamp, @message, @logStream
| filter @logStream like /your-ecs-log-stream-name/
| sort @timestamp desc
| limit 5000
"""

df = wr.cloudwatch.read_logs(
    log_group_names=[log_group],
    query=query,
    start_time=pd.Timestamp.now() - pd.Timedelta(weeks=1),
    end_time=pd.Timestamp.now()
)

print(f"取得件数: {len(df)}")

# `item: ` 以降がPythonリテラルなら `ast.literal_eval` で辞書に変換できる
def extract_item_data(text):
    try:
        text_str = str(text)
        if "item: " in text_str:
            dict_str = text_str.split("item: ", 1)[1]
            return ast.literal_eval(dict_str)
    except (ValueError, SyntaxError):
        return None
    return None

df['item_data'] = df['message'].apply(extract_item_data)
df = df.drop(columns=["logStream", "ptr"])
df
```
