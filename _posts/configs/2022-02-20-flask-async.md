---
layout: post
title: "flask async"
date: 2022-02-20
excerpt: "flaskでのasyncのやり方"
project: false
config: true
tag: ["flask", "celery", "api"]
comments: false
sort_key: "2022-05-13"
update_dates: ["2022-05-13"]
---

# flaskでasyncのやり方

## 概要
 - taskが完了する前にリターンコードを返す
 - 実装方法は様々にあるが、[/celery/](/celery/)を用いてRPCのtaskにする

## flaskによるasyncに対応した最小限のサーバの実装例

### celeryのタスク
 - `bin/task.py`のようなファイルにする
 - `celery -A bin.task worker --concurrency=1 --loglevel=CRITICAL`を実行する

```python
from celery import Celery

BROKER_URL = 'redis://localhost:6379/0'
BACKEND_URL = 'redis://localhost:6379/1'
app = Celery('tasks', broker=BROKER_URL, backend=BACKEND_URL)

@app.task
def job(arg):
    ... # なにか重い処理
    return True
```

### flaskのコードからceleryのタスクを呼ぶ
 - celeryのタスクを定義したファイルをimportする
 - celeryのIFで対象の関数を呼び出すと、非同期としてあつかえる

```python
from flask import Flask, request
from .task import job

# 取得
@app.route('/', methods=["GET"])
def home():
    obj = request.get_json()
    result = job.delay(obj) # ここで非同期にジョブが実行可能
    return f"async_job started. id = {result.id}", 200

if __name__ == '__main__':
    app.run(debug=True)
```

