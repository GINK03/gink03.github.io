---
layout: post
title: "python retry"
date: 2023-12-30
excerpt: "python retryの使い方"
project: false
config: true
tag: ["python", "retry"]
comments: false
sort_key: "2023-12-30"
update_dates: ["2023-12-30"]
---

# python retryの使い方

## 概要
 - 関数の実行をリトライするデコレータ
 - 例外が発生した場合にリトライする
 - オプション
   - `tries`: リトライ回数
   - `delay`: リトライ間隔
   - `jitter`: リトライ間隔のランダム要素
 
## インストール

```console
$ pip install retry
```

## 使い方

**基本的な使い方**
```python
from retry import retry

@retry(tries=3, delay=2, jitter=(0, 9))
def test_function():
    # ここにリトライしたい処理を書く
    print("関数を実行")
    raise ValueError("エラー発生")

try:
    test_function()
except Exception as e:
    print("最終的な失敗:", e)
```

**リトライする例外を指定する**
```python
from retry import retry

@retry(tries=3, delay=2, exceptions=ValueError)
def function_that_raises_value_error():
    raise ValueError("This is a ValueError")
```

**バックオフ戦略を使用**
```python
from retry import retry

# 最初のリトライは2秒後に実行され、二回目は4秒、三回目は8秒後に実行される
@retry(tries=3, delay=2, backoff=2)
def function_that_raises_value_error():
    raise ValueError("This is a ValueError")
```

**最大遅延時間を設定**
```python
from retry import retry

# 最大遅延時間を10秒に設定
@retry(tries=3, delay=2, backoff=2, max_delay=10)
def function_that_raises_value_error():
    raise ValueError("This is a ValueError")
```

**リトライの状況をログに記録**
```python
from retry import retry

def log_retry(attempt):
    print(f"リトライ {attempt}回目を実行中...")

@retry(tries=3, delay=2, on_retry=log_retry)
def function_with_logging():
    # 何らかの処理
    pass
```
