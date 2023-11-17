---
layout: post
title: "python fastapi"
date: 2023-11-17
excerpt: "pythonのfastapiの概要と使い方"
config: true
tag: ["python", "fastapi"]
comments: false
sort_key: "2023-11-17"
update_dates: ["2023-11-17"]
---

# pythonのfastapiの概要と使い方

## 概要
 - flaskのようなpythonのAPI専用のフレームワーク
 - [/pydantic](/pydantic/)を使用している
   - 型情報のバリデーションとドキュメント生成を行う
 - `/docs`でOpenAPIドキュメントを表示することができる
   - ドキュメントはBaseModelを継承したクラスの情報から生成される

## インストール

```console
$ pip install fastapi
```

## 起動
 - uvicornを使用する
   - 引数
     - `--reload`
       - ホットリロードをサポート
     - `--host 0.0.0.0`
       - 外部からアクセスを許可
     - `--port 8080`
       - ポートを指定する
   - 実行パス
     - `dir.main:app`
       - `dir`ディレクトリの`main.py`の`app`を実行する  

```console
$ uvicorn dir.main:app --reload --host 0.0.0.0 --port 8080
```

## サンプル

```python
from fastapi import FastAPI, Body
from pydantic import BaseModel, Field
import base64
import numpy as np
from typing import Tuple, List, Union, Dict

app = FastAPI()


class Base64Image(BaseModel):
    data: str = Field(..., description="Base64エンコードされた画像データを受け取る")
    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    "data": "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkS"
                }
            ]
        }
    }


class Response(BaseModel):
    message: str = Field(..., description="処理の成功または失敗を示すメッセージ")
    predict: Union[float, None] = Field(default=None, description="機械学習による判定結果")
    error: Union[str, None] = Field(default=None, description="エラーが発生した場合のエラーメッセージ")
    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    "message": "Processing was successful",
                    "predict": 0.5,
                },
                {
                    "message": "There was an error uploading the image",
                    "error": "Error message",
                },
            ]
        }
    }


@app.post("/predict/", response_model=Response)
async def predict(image: Base64Image):
    # クライアントから受け取ったBase64エンコードされた画像データをデコードする
    try:
        # ヘッダーがある場合は除去する
        header, encoded = image.data.split(",", 1) if "," in image.data else ("", image.data)
        decoded_image = base64.b64decode(encoded)
        # 何らかの処理
        predict = 0.5
    except Exception as e:
        return {"message": "There was an error uploading the image", "error": str(e)}
    return {"message": "Processing was successful", "predict": predict}
```
