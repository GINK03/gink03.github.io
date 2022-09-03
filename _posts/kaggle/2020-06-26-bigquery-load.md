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
 - twitterのランダムサンプル情報(pickle化したもの)をbigqueryにloadする例
 - pandasの`pandas.io.json.build_table_schema`関数を使用することでschema情報をダンプすることができる
 - load(アップロード)に失敗した場合はwebUIから確認できる

### 具体的な実装例

```python
# ref. https://stackoverflow.com/questions/59681072/can-you-load-json-formatted-data-to-a-bigquery-table-using-python-and-load-table

import pandas as pd
from tqdm.auto import tqdm
from pandas.io.json import build_table_schema
from google.cloud import bigquery
import io
from loguru import logger


filename = "../sda/twitter-random-sample/_agg_tweets/random_sample_tweet_0000.pkl"
x = pd.read_pickle(filename)

# ヒューリスティック(place情報はネストされたdictで面倒なので扱わない)
x.drop(columns=["place"], inplace=True)

x = x.head(50)
data = x.to_json(orient="records", lines=True)
# 末尾のブランクの改行を削除
data = data.strip()
lines = data.split("\n")

# BQで読み込み可能なスキーマ情報を、pandasの機能で作成する
# NULLABLE情報を追加
table_schema = build_table_schema(x)["fields"]
for x in table_schema:
    x["mode"] = "NULLABLE"

# 書き込み先のGCPプロジェクト, dataset, テーブル名を指定
# datasetが存在しない場合、エラーになる
client = bigquery.Client(project="starry-lattice-256603")
dataset = client.dataset("research_gimpei")
table = dataset.table("tmp")

# デフォルトでは追記する形でBQにデータを保存する
job_config = bigquery.LoadJobConfig()
job_config.source_format = bigquery.SourceFormat.NEWLINE_DELIMITED_JSON
job_config.schema = table_schema
logger.info(f"table_schema = {table_schema}")

# ファイルとして指定することで読み込むが、io.StringIO経由でも読み込める
job = client.load_table_from_file(io.StringIO(data), table, job_config=job_config)

# 結果を出力
logger.info(f"result = {job.result()}")
```

---

## 参考
 - [BigQuery - Where can I find the error stream?](https://stackoverflow.com/questions/52100812/bigquery-where-can-i-find-the-error-stream)
 - [Can you load JSON formatted data to a BigQuery table using Python and load_table_from_json()?](https://stackoverflow.com/questions/59681072/can-you-load-json-formatted-data-to-a-bigquery-table-using-python-and-load-table)
 - [pandas.io.json.build_table_schema/pandas](https://pandas.pydata.org/docs/reference/api/pandas.io.json.build_table_schema.html)
 - [スキーマの指定/GoolgeCloud](https://cloud.google.com/bigquery/docs/schemas?hl=ja#console)

