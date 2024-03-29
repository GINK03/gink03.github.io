---
layout: post
title: "gunicorn"
date: 2022-02-26
excerpt: "gunicronの使い方"
project: false
config: true
tag: ["gunicorn", "flask", "api", "python"]
comments: false
sort_key: "2022-05-11"
update_dates: ["2022-05-11","2022-02-26"]
---

# gunicornの使い方

## 概要
 - flaskなどのweb appをラップして実用的なAPI(web)機能を提供する

## インストール

```console
$ python3 -m pip install gunicorn
```

## 起動オプション
 - `--bind <ip-address>:<port>`
   - ip-address
     - アクセスを許可するIP
   - port
     - gunucornの起動するポート
 - `--workers=<num>`
   - num
     - ワーカー数 
 - `--timeout=<num>`
   - num
     - タイムアウトの秒数(second)

## 具体例

### flaskのコードをgunicornで起動する
 - flask単体だと、同じ位置のファイルをインポートできるが、gunicornからだとインポートできない
   - `Failed to find attribute 'app' in 'src.bin'`のようなエラーが出る
   - `__init__.py`にて明示的に`from .app import app`を追加する必要がある

#### ディレクトリ構造

```console
.
├── README.md
├── bin
│   ├── __init__.py
│   └── wsgi.py
└── var
    ├── META.pkl
    ├── model.pkl
...
```

#### コード

```python
from flask import Flask, request, jsonify
import json
from pathlib import Path
from loguru import logger

WD = Path(__file__).parent.parent.absolute()
logger.info(f"working directory is {WD}")

app = Flask(__name__)

@app.route('/', methods=["GET"])
def home():
    return "foobar"

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
```

#### 起動コマンド

```console
$ gunicorn --bind 127.0.0.1:4400 --workers=2 --timeout=600 bin:app
```
 - `--bind 127.0.0.1`はローカルホストからのみのアクセスを許可する
 - `--bind 0.0.0.0`にするとすべてのアクセスを許可する
