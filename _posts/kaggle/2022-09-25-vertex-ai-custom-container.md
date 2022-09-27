---
layout: post
title: "gcp vertex ai custom container"
date: 2022-09-25
excerpt: "gcp vertex ai custom containerの使い方"
kaggle: true
tag: ["gcp", "vertex ai"]
sort_key: "2022-09-25"
update_dates: ["2022-09-25"]
comments: false
---

# gcp vertex ai custom containerの使い方

## 概要
 - Cloud Runで走らせるには不足するような場合(GPUを使いたい場合など)、マネージドにAPIをサーブできる

## カスタムコンテナに必要な条件
 - ヘルスチェックに対応していること
   - `/health`などのアクセスに対して`200 OK`を返せること
 - 環境変数からルーティングを参照して、変化させられること
 - 特定の入力形式のjsonであること
 - 特定の出力形式のjsonであること

### 特定の入力形式のjson

```json
{
  "instances": [
    { "key1": "val1"},
    { "key2": "val2"}
  ],
  "parameters": { "key1": "val1" }
}
```

### 特定の出力形式のjson

```json
{
  "predictions": [
    "predict 1",
    "predict 2"
  ]
}
```

## 具体的なサンプルコード

```python
import json
from typing import List
from loguru import logger
import json
from flask import Flask
from flask import request
import os

app = Flask(__name__)

# GCPにより動的に決定されるルート
AIP_PREDICT_ROUTE = os.environ.get("AIP_PREDICT_ROUTE", "/predict")
logger.info(f'AIP_PREDICT_ROUTE = {AIP_PREDICT_ROUTE}')

@app.route(AIP_PREDICT_ROUTE, methods=['GET', 'POST'])
@app.route('/hello-world', methods=['GET', 'POST'])
def hello_world():
    # POSTのデータがないと例外が起きる
    # obj = request.get_json()
    match request.data:
        case b"":
            return "no parameters", 400
        case x:
            obj = json.loads(x, strict=False)
    logger.info(f"input obj = {obj}")
    return json.dumps({"predictions": ["hello world."]})

@app.route('/health', methods=['GET', 'POST'])
def health():
    return "OK", 200

@app.errorhandler(404)
def page_not_found(error):
    logger.warning(f'unexpected url was called. requst.url = {request.url}')
    return f"not found interface. request.url = {request.url}", 404
```

### 具体的なクエリ

```console
$ curl \
-X POST \
-H "Authorization: Bearer $(gcloud auth print-access-token)" \
-H "Content-Type: application/json" \
https://us-central1-aiplatform.googleapis.com/v1/projects/${PROJECT_ID}/locations/us-central1/endpoints/${ENDPOINT_ID}:predict \
-d "@${INPUT_DATA_FILE}"
```

---

## 参考
 - [Custom container requirements for prediction/GoogleCloud](https://cloud.google.com/vertex-ai/docs/predictions/custom-container-requirements)
 - [Use a custom container for prediction/GoogleCloud](https://cloud.google.com/vertex-ai/docs/predictions/use-custom-container)
 - [Google Cloud コンソールを使用してモデルをデプロイする/GoogleCloud](https://cloud.google.com/vertex-ai/docs/predictions/deploy-model-console#custom-trained)
