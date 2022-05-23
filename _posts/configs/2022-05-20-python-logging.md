---
layout: post
title: "python logging"
date: "2022-05-20"
excerpt: "python loggingの使い方"
project: false
config: true
tag: ["python", "logging"]
comments: false
sort_key: "2022-05-20"
update_dates: ["2022-05-20"]
---

# python loggingの使い方

## 概要
 - pythonのデフォルトライブラリのlogging機能
 - globalなシングルトンとしてのloggingとインスタンスを初期化してのloggingがある
   - シングルトン
     - モジュールを直接呼び出せる
     - basicConfigで設定できる
       - 設定は必ず最初に行わないとhandlerが自動生成される
     - stdoutとfileの両方に書き出すことができない
   - インスタンス
     - 明確に特定の名前空間で使用できる
     - 複数のハンドラーを明示的に登録できる
     - 初期化コードが長い
 - もっと簡単に使いたいとき
   - [/loguru/](/loguru/)を参照

## シングルトンでlogging機能を使う

### 具体例

```python
import logging
import sys

# インスタンスを何度も作成すると、handlerに次々に追加されてしまう
format = '%(asctime)s %(message)s'
logging.basicConfig(# filename="/tmp/output.log", # ファイル名を指定するとstreamhandlerが無効になる
                    stream=sys.stdout,
                    level=logging.DEBUG,
                    format=format)
logging.warning('this is a test log message')
# 2022-05-20 08:03:01,944 this is a test log message
```

## loggerインスタンスを作成してlogging機能を使う

### 具体例

```python
# loggerインスタンスを取得
logger = logging.getLogger("foo-bar-logger") # 名前をつけてloggingインスタンスを取得
logger.setLevel(logging.INFO) # ログレベルを設定

# fileに出力するハンドラー
handler_file = logging.FileHandler("/tmp/output.log")
handler_file.setLevel(logging.INFO)
formatter = logging.Formatter("this is file, %(asctime)s - %(name)s - %(levelname)s - %(message)s")
handler_file.setFormatter(formatter)
logger.addHandler(handler_file) 

# stdoutに出力するハンドラー
handler_stream = logging.StreamHandler(sys.stdout)
handler_stream.setLevel(logging.INFO)
formatter = logging.Formatter("this is stream, %(asctime)s - %(name)s - %(levelname)s - %(message)s")
handler_stream.setFormatter(formatter)
logger.addHandler(handler_stream) # loggingインスタンスは複数のhandlerを登録できる

logger.info("aaa")

# stdout => this is stream, 2022-05-20 07:55:41,999 - foo-bar-logger - INFO - aaa
# !cat => this is file, 2022-05-20 08:04:46,651 - foo-bar-logger - INFO - aaa
```

## Google Colab
 - [python-logging](https://colab.research.google.com/drive/1IIJeZ1FtzPZOn4A6MiX2Wrb7mVcw2yQH?usp=sharing)

---

## formatの設定項目
 - format
   - asctime
     - 時間
   - filename
     - ファイル名
   - fucName
     - 関数名
   - lineno
     - line no
   - module
     - モジュール名
   - name
     - ロガーの名前
   - levelname
     - エラーレベル
   - message
     - メッセージ

## 参考
 - [logging — Logging facility for Python](https://docs.python.org/3/library/logging.html)
