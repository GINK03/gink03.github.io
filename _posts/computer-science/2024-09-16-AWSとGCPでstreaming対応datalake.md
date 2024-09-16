---
layout: post
title: "AWSとGCPでstreaming対応datalake"
date: 2024-09-16
excerpt: "AWSとGCPでstreaming対応datalakeについて"
computer_science: true
tag: ["AWS", "GCP", "datalake", "クラウドデザインパターン"]
comments: false
sort_key: "2024-09-16"
update_dates: ["2020-09-16"]
---

# AWSとGCPでstreaming対応datalakeについて

## 概要
 - AWSとGCPでstreaming対応datalakeの構築方法について
 - 特に、aws上で動作させているプロダクトのログをgcpのbigqueryで分析するパターンの例を紹介

## 想定するデータフロー
 1. ログがaws上の何らかのプロダクトから出力される
 2. ログがaws cloudwatch logsに蓄積される
 3. aws lambdaがcloudwatch logsのstreamイベントでトリガーされる
 4. bigqueryにaws lambdaからstreamingで書き込まれる

## `1. ログがaws上の何らかのプロダクトから出力される`, `2. ログがaws cloudwatch logsに蓄積される`
 - [/aws-cloudwatch-logs/](/aws-cloudwatch-logs/)を参考

## `3. aws lambdaがcloudwatch logsのstreamイベントでトリガーされる`, `4. bigqueryにaws lambdaからstreamingで書き込まれる`
 - 事前にbigqueryの対応したスキーマのテーブルを作成
 - bigqueryへ書き込み権限があるサービスアカウントを作成し、その認証情報をaws lambdaに設定
 - aws lambdaを作成し、cloudwatch logsのstreamイベントでトリガーされるように設定

**bigqueryのテーブルのschemeの例**
```json
[
  {
    "name": "timestamp",
    "type": "TIMESTAMP",
    "mode": "REQUIRED",
    "description": "Timestamp in milliseconds since the epoch"
  },
  {
    "name": "session_id",
    "type": "INT64",
    "mode": "REQUIRED",
    "description": "Unique ID for the session"
  },
  {
    "name": "action",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "Action name or type"
  },
  {
    "name": "params",
    "type": "JSON",
    "mode": "NULLABLE",
    "description": "Action parameters as a JSON object"
  }
]
```

**aws lambdaのコード例**
```python
import base64
import gzip
import boto3
import datetime
from google.cloud import bigquery
import os
import time

# S3 からサービスアカウントの認証ファイルをダウンロード
# 必要に応じてsecret managerなどを利用
s3_client = boto3.client('s3')
s3_client.download_file('your-bucket-name', 'your-file', '/tmp/service_account.json')
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = '/tmp/service_account.json'

# BigQuery クライアントを初期化 (サービスアカウントの認証ファイルが Lambda 環境変数に指定されていることを前提)
client = bigquery.Client()
# 環境変数から BigQuery のテーブル ID を取得
TABLE_ID = os.getenv('BIGQUERY_TABLE_ID')

def lambda_handler(event, context):
    # CloudWatch Logs から受信したデータを解凍して解析
    log_data_compressed = event['awslogs']['data']
    compressed_payload = base64.b64decode(log_data_compressed)
    uncompressed_payload = gzip.decompress(compressed_payload)
    log_data = json.loads(uncompressed_payload)

    # ログデータをパースし、BigQuery に挿入するデータの整形
    rows_to_insert = []
    for log_event in log_data['logEvents']:
        # CloudWatch Logs のフォーマットに基づいてログメッセージをパース
        message = json.loads(log_event['message'])

        # タイムスタンプを秒に変換し、datetime オブジェクトに変換
        timestamp_in_seconds = log_event['timestamp'] / 1000
        timestamp = datetime.datetime.utcfromtimestamp(timestamp_in_seconds).isoformat()

        # params フィールドをシリアライズされた JSON 文字列に変換
        params = message.get('params', None)
        if params is not None:
            params = json.dumps(params)

        # BigQuery テーブルに適合するデータの整形
        row = {
            'timestamp': timestamp,  # ISO 8601 形式の文字列で指定
            'sessiond_id': message.get('session_id', 0),  # session_id がなければ 0 を使用
            'action': message.get('action', None),  # action がない場合は None
            'params': params
        }
        rows_to_insert.append(row)

    # BigQuery にデータを挿入
    errors = client.insert_rows_json(TABLE_ID, rows_to_insert)
    if errors == []:
        print("New rows have been added successfully.")
    else:
        print(f"Errors occurred while inserting rows: {errors}")
    return {
        'statusCode': 200,
        'body': json.dumps('Log processed and sent to BigQuery')
    }
```
