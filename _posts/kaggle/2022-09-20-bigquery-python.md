---
layout: post
title: "bigquery python"
date: 2022-09-20
excerpt: "bigquery pythonのチートシート"
tags: ["bq", "bigquery", "gcp"]
kaggle: true
comments: false
sort_key: "2022-09-20"
update_dates: ["2022-09-20"]
---

# bigquery pythonのチートシート

## 概要
 - [/pandas-gbq/](/pandas-gbq/)とは別のGoogleオフィシャルのpythonバインディング
   - pandas-gbqより安定していると言われている
 - BQへのストリームライトなどをサポートする

## モジュールのインストール

```console
$ python3 -m pip install google-cloud-bigquery
```

## 具体例

### BQからデータをpandasで取得する

```python
from google.cloud import bigquery
import pandas as pd

# クライアントを初期化
client = bigquery.Client()

# クエリを設定
query = """
    SELECT name, SUM(number) as total_people
    FROM `bigquery-public-data.usa_names.usa_1910_2013`
    WHERE state = 'TX'
    GROUP BY name
    ORDER BY total_people DESC
    LIMIT 20
"""

# クエリを実行してDataFrameに結果を格納
df = client.query(query).to_dataframe()

# 結果を表示
print(df)
```

### BQにデータのチャンクを書き込む

```python
from google.cloud import bigquery

# クライアントを設定
client = bigquery.Client()

# テーブルIDを指定
table_id = "your-project.your_dataset.your_table"

# テーブルに挿入する行を準備
rows_to_insert = [
    {"column_name": "value1", "other_column_name": "value2"},  # 例としての行データ
    # その他の行データ...
]

# テーブルにデータを挿入
errors = client.insert_rows_json(table_id, rows_to_insert)  # API request

# 結果を確認
if errors == []:
    print("New rows have been added.")
else:
    print("Errors occurred:", errors)
```

### BQをバックエンドに設定した勤怠管理システム

```python
import os
from google.cloud import bigquery
import datetime
from flask import Flask, request, jsonify, render_template, make_response, abort
from pathlib import Path
from loguru import logger

application = Flask(__name__)
JST = datetime.timezone(datetime.timedelta(hours=+9), 'JST')


def initial_bq():
    logger.info(f"start to init bq...")
    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = str(Path("~/.var/bq-credential.json").expanduser())
    client = bigquery.Client()
    table_id = "starry-lattice-256603.attendances.logs"
    table = client.get_table(table_id)
    logger.info(f"end to init bq...")
    return client, table


CLIENT, TABLE = initial_bq()


def insert_row(row):
    errors = CLIENT.insert_rows(TABLE, [row])
    if errors == []:
        logger.info("New rows have been added.")
        return "ok"
    else:
        logger.error(f"{errors}")
        return "err"

@application.route("/start_attendance")
def start_attendance():
    return insert_row((datetime.datetime.now(JST), "出勤"))


@application.route("/end_attendance")
def end_attendance():
    return insert_row((datetime.datetime.now(JST), "退勤"))


if __name__ == "__main__":
    application.run(host='0.0.0.0', port=2345)
```

## トラブルシューティング

### `OSError: Project was not passed and could not be determined from the environment.`
 - 原因
   - 使用するプロジェクトが特定できない
 - 対応
   - `export GCLOUD_PROJECT=my-project-1234`などで環境変数を設定する
