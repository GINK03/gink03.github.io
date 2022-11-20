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
 - BQへのストリームライトなどをサポートする

## モジュールのインストール

```console
$ python3 -m pip install google-cloud-bigquery
```

## 具体例

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
