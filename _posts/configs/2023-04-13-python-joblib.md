---
layout: post
title: "python joblib"
date: 2023-04-13
excerpt: "pythonのjoblibの使い方"
config: true
tag: ["python", "joblib"]
comments: false
sort_key: "2023-04-14"
update_dates: ["2023-04-14"]
---

# pythonのjoblibの使い方

## 概要
 - on-demand computing
 - Transparent parallelization

## インストール

```console
$ python3 -m pip install joblib
```

## 並列化
 - デフォルトではプロセスベース
   - `n_jobs=-1`ですべてのプロセスを使用する
 - `with parallel_backend('threading', n_jobs=n_jobs):`でくくるとthredingベースで並列化を行う
 - `delayed`は遅延関数化するラッパー
 - `tqdm`を利用する際は`delayed`インスタンスを作成するイテレータのリスト内包表記に記す

### 並列化の具体例
 - GCPのセンチメント分析を並列でアクセスする場合

```python
from joblib import Parallel, delayed
from joblib import parallel_backend

with parallel_backend('threading', n_jobs=5):
    Parallel()(delayed(gcp_analyze_entity_sentiment)(text) for text in df.sample(frac=1)["text"])
```

### 共有メモリを利用したマルチプロセスの並列化の例
 - 共有化できるのはnumpy objectに限定される

```python
import numpy as np
from joblib import Parallel, delayed
from joblib import load, dump, cpu_count

def update_array(shared_array_path, index, value):
    shared_array = load(shared_array_path, mmap_mode="r+")
    shared_array[index] = value

array_size = 5
max_string_length = 10
original_array = np.array([""] * array_size, dtype=f'S{max_string_length}')

# 共有メモリに配列を書き込みます
shared_array_path = dump(original_array, "/dev/shm/shared_array")[0]

# 共有メモリ上の配列を更新するタスクを作成します
tasks = [delayed(update_array)(shared_array_path, i, f"Text-{i}") for i in range(array_size)]

# タスクを並行して実行します
Parallel(n_jobs=cpu_count(), backend="multiprocessing")(tasks)

# 更新された共有メモリ上の配列を読み込みます
updated_array = load(shared_array_path, mmap_mode="r")
print("Updated Array:", updated_array)
"""
Updated Array: [b'Text-0' b'Text-1' b'Text-2' b'Text-3' b'Text-4']
"""
```

---

## 参考
 - [joblib.Parallel/joblib.readthedocs.io](https://joblib.readthedocs.io/en/latest/generated/joblib.Parallel.html)
