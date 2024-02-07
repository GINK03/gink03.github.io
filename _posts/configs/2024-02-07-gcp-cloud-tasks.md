---
layout: post
title: "gcp cloud tasks"
date: 2024-02-07
excerpt: "gcp cloud tasksの概要と使い方"
tags: ["gcp", "cloud tasks", "api"]
config: true
comments: false
sort_key: "2024-02-07"
update_dates: ["2024-02-07"]
---

# gcp cloud tasksの概要

## 概要
 - gcpのタスクキューサービス
 - self-hostedのrabbitmqやredisのようなもの
 - タスクのスケジューリング、秒間ディスパッチ数、リトライ、タイムアウト、キューの管理ができる

## キューの作成

```console
$ gcloud tasks queues create <queue-name> \
  --location=<location> \ # リージョン
  --max-dispatches-per-second=1 \ # 秒間ディスパッチ数
  --max-concurrent-dispatches=1 \ # 同時ディスパッチ数
  --max-attempts=5 \ # リトライ回数
  --max-backoff=3600s \ # リトライの最大バックオフ
  --min-backoff=5s # リトライの最小バックオフ
```

## httpタスクの追加(python)

```python
from google.cloud import tasks_v2
from google.protobuf import timestamp_pb2
import datetime

# Google CloudプロジェクトID、キューID、およびキューのリージョンを設定
project = '<project-id>'  # Google Cloud プロジェクトID
queue = '<queue-name>'  # 作成したキューのID
location = '<location>'  # キューのリージョン（例：'us-central1'）
url = '<url>'  # タスクによってアクセスされるURL
payload = 'Hello, World!'  # タスクリクエストのペイロード（必要に応じて）

# Cloud Tasksクライアントを初期化
client = tasks_v2.CloudTasksClient()

# キューの完全なパスを構築
parent = client.queue_path(project, location, queue)

# タスクのHTTPRequestを構成
task = {
    'http_request': {  # タスクの詳細を指定
        'http_method': tasks_v2.HttpMethod.POST,
        'url': url,
        'body': payload.encode()
    }
}

# オプション：タスクのスケジュール時刻を設定
schedule_time = datetime.datetime.utcnow() + datetime.timedelta(seconds=30)  # 30秒後
schedule_timestamp = timestamp_pb2.Timestamp()
schedule_timestamp.FromDatetime(schedule_time)
task['schedule_time'] = schedule_timestamp

# タスクをキューに追加
response = client.create_task(parent=parent, task=task)

print('Task created: {}'.format(response.name))
```

## httpサーバの作成(python)

```python
from flask import Flask, request

app = Flask(__name__)

@app.route('/', methods=['POST'])
def handle_post():
    # リクエストのボディを取得
    data = request.data.decode('utf-8')  # バイナリデータを文字列にデコード
    print(f"Received data: {data}")  # コンソールに受け取ったデータを表示
    return 'Data received\n', 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=18080, debug=True)
