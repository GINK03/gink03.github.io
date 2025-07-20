---
layout: post
title: "python context manager"
date: "2022-11-17"
excerpt: "pythonのcontext managerの使い方"
config: true
tag: ["python", "context manager", "with", "decorator", "class"]
comments: false
sort_key: "2022-11-17"
update_dates: ["2022-11-17"]
---

# pythonのcontext managerの使い方

## 概要
 - `with`ステートメントで自動でリソースを開放するを行える機能
 - 関数デコレータで実装する方法と、クラスで実装する方法がある
 - `with`を使用せずに`__enter__`と`__exit__`メソッドを呼ぶことでも使用可能

## withを使用しない例(pandasの表示設定)

```python
def display_full(df): (lambda c: (c.__enter__(), display(df), c.__exit__()))\
    (pd.option_context("display.max_colwidth", None, "display.max_rows", None, "display.max_columns", None))
```

## 関数デコレータで実装する方法(処理の開始と終了をログに出力する例)

```python
from contextlib import contextmanager

@contextmanager
def section(name):
    print(f"=== {name} 開始 ===")
    yield
    print(f"=== {name} 終了 ===")

with section("データ読み込み"):
    # データを読み込む処理
    data = load_data()
    print("データを読み込みました")

with section("データ処理"):
    # データを処理するコード
    processed_data = process_data(data)
    print("データを処理しました")
```

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

## Google Colab
 - [コンテキストマネージャー](https://colab.research.google.com/drive/1iKbu9mjcp6tOzSlZkvLJOZtItigNXCwR?usp=sharing)

---

## 参考
 - [contextlib — Utilities for with-statement contexts](https://docs.python.org/3/library/contextlib.html)
