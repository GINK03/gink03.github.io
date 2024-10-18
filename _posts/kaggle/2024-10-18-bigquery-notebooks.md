---
layout: post
title: "bigquery notebooks"
date: 2024-10-18
excerpt: "bigquery notebooksの使い方"
tags: ["bigquery", "notebooks"]
kaggle: true
comments: false
sort_key: "2024-10-18"
update_dates: ["2024-10-18"]
---

# bigquery notebooksの使い方

## 概要
 - BigQueryのweb UI上でJupyter notebookを使える機能
   - BigQuery上のデータのアクセス方法がJupyter notebookと少し異なる
 - 前提としてBigQuery APIが有効になっている必要がある
   - [APIの有効化](https://console.cloud.google.com/apis/enableflow?apiid=bigquery.googleapis.com&hl=ja)

## 使い方

**データのロード**
```python
%%bigquery results --project cosmic-bonfire-354108
SELECT * FROM `project.dataset.table`

results # resultsにデータが格納される
```

**bigframeの利用**
```python
import bigframes.pandas as bf

bf.options.bigquery.location = "asia-northeast1"
bf.options.bigquery.project = "project"

df = bf.read_gbq("project.dataset.table")

df.head(10)
```

## 参考
 - [ノートブックの概要 - cloud.google.com](https://cloud.google.com/bigquery/docs/notebooks-introduction?hl=ja)
