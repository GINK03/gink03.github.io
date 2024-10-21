---
layout: post
title: "huggingface datasets"
date: 2023-05-27
excerpt: "huggingface datasetsの使い方"
kaggle: true
hide_from_post: true
tag: ["huggingface", "datasets", "python"]
comments: false
sort_key: "2023-05-27"
update_dates: ["2022-05-27"]
---

# huggingface datasetsの使い方

## 概要
 - huggingfaceのデータセットのレポジトリにコードからアクセスできるツール
 - 一部の前処理なども含まれている

## インストール

```console
$ pip install datasets
```

## 具体例

**IMDBデータセットを使う**
```python
from datasets import load_dataset
dataset = load_dataset('imdb', split="train") 
dataset.to_pandas()
```

**MS MARCO データセットをストリーミングでロードし、最初の10件を取得**
```python
import pandas as pd
from datasets import load_dataset

dataset = load_dataset("ms_marco", "v1.1", split="train", streaming=True).take(10)
data_list = list(dataset)
df = pd.DataFrame(data_list)
df
```

## 参考
 - [huggingface/datasets](https://github.com/huggingface/datasets)
