---
layout: post
title: "python context manager"
date: "2022-11-17"
excerpt: "pythonのcontext managerの使い方"
config: true
tag: ["python", "context manager"]
comments: false
sort_key: "2022-11-17"
update_dates: ["2022-11-17"]
---

# pythonのcontext managerの使い方

## 概要
 - `with`ステートメントで自動でリソースを開放するを行える機能
 - 関数デコレータで実装する方法と、クラスで実装する方法がある

## クラスで実装する方法

```python
# クラスで定義する方法
class MyMeasureContextManager:
    def __init__(self):
        self.tlog = None
    def __enter__(self):
        self.tlog = time.time()
    def __exit__(self, type, value, traceback):
        elp = time.time() - self.tlog
        logger.info(f"exit, elapsed = {elp}")

with MyMeasureContextManager():
    time.sleep(1.0)
"""
2022-11-17 04:11:03.385 | INFO     | __main__:__exit__:8 - exit, elapsed = 1.0011460781097412
"""
```

## 関数デコレータで実装する方法

```python
from contextlib import contextmanager
from loguru import logger
import time
from typing import Any

@contextmanager
def measure_time(any: Any = None):
    tlog = None
    try:
        tlog = time.time()
        yield None # ここで受け取ったインスタンスを返す
    finally:
        elp = time.time() - tlog
        logger.info(f"exit, elapsed = {elp}")
        if any:
           del any # インスタンス引数があればそれを削除

with measure_time():
    time.sleep(1.0)
"""
2022-11-17 04:03:28.849 | INFO     | __main__:closing:14 - exit, elapsed = 1.0011351108551025
"""
```

## Google Colab
 - [コンテキストマネージャー](https://colab.research.google.com/drive/1iKbu9mjcp6tOzSlZkvLJOZtItigNXCwR?usp=sharing)

---

## 参考
 - [contextlib — Utilities for with-statement contexts](https://docs.python.org/3/library/contextlib.html)
