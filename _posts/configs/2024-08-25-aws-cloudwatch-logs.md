---
layout: post
title: "aws cloudwatch logs"
date: 2024-08-25
excerpt: "aws cloudwatch logsの概要と使い方"
project: false
config: true
tag: ["aws", "cloudwatch", "logs"]
comments: false
sort_key: "2024-08-25"
update_dates: ["2024-08-25"]
---

# aws cloudwatch logsの概要と使い方

## 概要
 - aws cloudwatch logsは、awsのログ管理サービス
 - ログを収集・保存・検索・監視することができる
 - 分析する場合は、s3に保存してathenaでクエリを投げるのが一般的

## pythonからログを送信する

```python
import boto3
import logging
import time
import json
from botocore.exceptions import NoCredentialsError, PartialCredentialsError

# ロググループとログストリームの設定
log_group_name = 'my-log-group'
log_stream_name = 'my-log-stream'

# boto3クライアントの作成
client = boto3.client('logs')

try:
    # ロググループの作成 (存在しない場合)
    client.create_log_group(logGroupName=log_group_name)
except client.exceptions.ResourceAlreadyExistsException:
    pass

try:
    # ログストリームの作成 (存在しない場合)
    client.create_log_stream(logGroupName=log_group_name, logStreamName=log_stream_name)
except client.exceptions.ResourceAlreadyExistsException:
    pass

def log_to_cloudwatch(json_object):
    # JSONオブジェクトをJSONL形式（1行に1つのJSON）に変換
    message = json.dumps(json_object)
    
    # ログストリームのシーケンストークンを取得
    response = client.describe_log_streams(logGroupName=log_group_name, logStreamNamePrefix=log_stream_name)
    upload_sequence_token = response['logStreams'][0].get('uploadSequenceToken')

    log_event = {
        'logGroupName': log_group_name,
        'logStreamName': log_stream_name,
        'logEvents': [
            {
                'timestamp': int(time.time() * 1000),
                'message': message
            }
        ],
    }

    if upload_sequence_token:
        log_event['sequenceToken'] = upload_sequence_token

    response = client.put_log_events(**log_event)
    return response

# JSONオブジェクトとしてログメッセージを作成
log_message = {
    "time": "2023-08-24T12:00:00Z",
    "level": "INFO",
    "message": "User login",
    "user_id": 123
}

# ログメッセージの送信
log_to_cloudwatch(log_message)
```

## S3にログを保存する

```console
$ aws logs create-export-task \
    --task-name "export-task-$(date '+%Y-%m-%d-%H-%M-%S')" \
    --log-group-name "my-log-group" \
    --from "$(date -d '1 day ago' +%s)000" \
    --to "$(date +%s)000" \
    --destination "my-bucket-name" \
    --destination-prefix "logs/my-log-file/"
```
