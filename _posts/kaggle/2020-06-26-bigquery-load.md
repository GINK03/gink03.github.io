---
layout: post
title: "bigquery load"
date: 2020-09-03
excerpt: "bigquery load(bqへのデータのアップロード)のチートシート"
tags: ["bq", "bigquery", "gcp", "load"]
kaggle: true
comments: false
sort_key: "2022-09-03"
update_dates: ["2022-09-03"]
---

# bigquery load(bqへのデータのアップロード)のチートシート

## 概要
 - `bq`コマンドでアップロードする方法とpython等のスクリプトでload(アップロード)する方法などがある

## pythonでデータをアップロードする
 - pandasの`pandas.io.json.build_table_schema`関数を使用することでschema情報をダンプすることができる
 - load(アップロード)に失敗した場合はwebUIから確認できる

### 具体的な実装例

```python
# ref. https://stackoverflow.com/questions/59681072/can-you-load-json-formatted-data-to-a-bigquery-table-using-python-and-load-table
import glob
import pandas as pd
from pandas.io.json import build_table_schema
from google.cloud import bigquery
import io
from loguru import logger
from tqdm.auto import tqdm

project = "your_project_id"
dataset_name = "your_dataset_name"

def load_to_bigquery(x: pd.DataFrame, table_name: str):
    # BQで読み込み可能なスキーマ情報を、pandasの機能で作成する
    # NULLABLE情報を追加
    table_schema = build_table_schema(x, index=False)["fields"]
    for schema in table_schema:
        if schema["type"] == "number":
            schema["type"] = "FLOAT"  # NUMBER を FLOAT に修正
        schema["mode"] = "NULLABLE"

    # そのままjson化すると、unixtimeになってしまうので、文字列に変換(必要に応じて変更)
    x["created_at"] = x["created_at"].dt.strftime("%Y-%m-%d %H:%M:%S")
    data = x.to_json(orient="records", lines=True)
    # 末尾のブランクの改行を削除
    data = data.strip()
    lines = data.split("\n")

    # 書き込み先のGCPプロジェクト, dataset, テーブル名を指定
    # datasetが存在しない場合、エラーになる
    client = bigquery.Client(project=project)
    dataset = client.dataset(dataset_name)
    table = dataset.table(table_name)

    # デフォルトでは追記する形でBQにデータを保存する
    job_config = bigquery.LoadJobConfig()
    job_config.source_format = bigquery.SourceFormat.NEWLINE_DELIMITED_JSON
    job_config.schema = table_schema
    # パーティションを使用しない場合はこの設定は必要ない
    # この例ではDAY単位でパーティションを作成すが、他にもHOUR, MONTH, YEARが指定可能
    # (DAYではパーティションの更新界数が多すぎてクオータ制限に引っかかることがあるのでその場合はMONTHなどに変更する)
    job_config.time_partitioning = bigquery.TimePartitioning(
        type_=bigquery.TimePartitioningType.DAY,
        field="created_at",  # パーティションに使うカラム
        # expiration_ms=7776000000,  # 90 days.
    )
    logger.info(f"table_schema = {table_schema}")
    # ファイルとして指定することで読み込むが、io.StringIO経由でも読み込める
    job = client.load_table_from_file(io.StringIO(data), table, job_config=job_config)
    # 結果を出力
    logger.info(f"result = {job.result()}")

# 以下は参考程度
for filename in tqdm(glob.glob("./twitter-random-sample/_agg_tweets/*.pkl")):
    x = pd.read_pickle(filename)
    x = x[['screen_name', 'name', 'description', 'url', 'created_at', 'text', 'source']]
    x["created_at"] = pd.to_datetime(x["created_at"], format="%a %b %d %H:%M:%S +0000 %Y") + pd.DateOffset(hours=9)
    load_to_bigquery(x)
```

## 参考
 - [列ベースの時間パーティション分割テーブルにデータを読み込む/GoogleCloud](https://cloud.google.com/bigquery/docs/samples/bigquery-load-table-partitioned?hl=ja#bigquery_load_table_partitioned-python)
 - [BigQuery - Where can I find the error stream?](https://stackoverflow.com/questions/52100812/bigquery-where-can-i-find-the-error-stream)
 - [Can you load JSON formatted data to a BigQuery table using Python and load_table_from_json()?](https://stackoverflow.com/questions/59681072/can-you-load-json-formatted-data-to-a-bigquery-table-using-python-and-load-table)
 - [pandas.io.json.build_table_schema/pandas](https://pandas.pydata.org/docs/reference/api/pandas.io.json.build_table_schema.html)
 - [スキーマの指定/GoolgeCloud](https://cloud.google.com/bigquery/docs/schemas?hl=ja#console)

