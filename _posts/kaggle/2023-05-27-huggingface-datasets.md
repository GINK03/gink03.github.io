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

## インストール

```console
$ python3 -m pip install datasets
```

## 具体例

### 使用できるデータセットの確認

```python
from datasets import list_datasets, load_dataset

df = pd.DataFrame({"dataset": list_datasets()})
df
```

### データを加工する

```python
from datasets import list_datasets, load_dataset


# Load a dataset and print the first example in the training set
dataset = load_dataset('squad')

# Process the dataset - add a column with the length of the context texts
dataset_with_length = dataset.map(lambda x: {"length": len(x["context"])})

# Process the dataset - tokenize the context texts (using a tokenizer from the 🤗 Transformers library)
from transformers import AutoTokenizer
tokenizer = AutoTokenizer.from_pretrained('bert-base-cased')

tokenized_dataset = squad_dataset.map(lambda x: tokenizer(x['context']), batched=True)
```

## 参考
 - [huggingface/datasets](https://github.com/huggingface/datasets)
