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
 - `with parallel_backend('threading', n_jobs=n_jobs):`でくくるとthredingベースで並列化を行う
 - `delayed`は遅延関数化するラッパー

### 並列化の具体例
 - GCPのセンチメント分析を並列でアクセスする場合

```python
from joblib import Parallel, delayed
from joblib import parallel_backend

with parallel_backend('threading', n_jobs=5):
    Parallel()(delayed(gcp_analyze_entity_sentiment)(text) for text in df.sample(frac=1)["text"])
```

---

## 参考
 - [joblib.Parallel/joblib.readthedocs.io](https://joblib.readthedocs.io/en/latest/generated/joblib.Parallel.html)
