---
layout: post
title: "bigquery remote functions"
date: 2022-11-07
excerpt: "bigquery remote functionsのチートシート"
tags: ["bq", "bigquery", "gcp", "remote functions"]
kaggle: true
comments: false
sort_key: "2022-11-07"
update_dates: ["2022-11-07"]
---

# bigquery remote functionのチートシート

## 概要
 - BigQueryで任意のAPIにアクセスするためのインターフェース
 - cloud functions, cloud runなどにホストしたAPIをBQで利用できる

## connection(cloud resource)を作成する

```console
$ bq mk --connection 
        --display_name='friendly name' 
        --connection_type=CLOUD_RESOURCE
        --project_id=my-project-id --location=US my-connection
```

## connection(cloud resource)の確認

```console
$ bq show --location=US --connection  my-connection
```

## BigQuery側でAPIにアクセスする関数を作成する

```sql
CREATE FUNCTION my_bq_project.my_dataset.remote_add(x INT64, y INT64) RETURNS INT64
REMOTE WITH CONNECTION `my-project-id.us.my-connection`
OPTIONS (endpoint = 'https://us-east1-my_gcf_project.cloudfunctions.net/remote_add')
```

---

## 参考
 - [リモート関数の操作/Google Cloud](https://cloud.google.com/bigquery/docs/reference/standard-sql/remote-functions)
 - [BigQuery リモート関数で Natural Language API を使って、SQL でお客様レビューの感情分析してみた](https://dev.classmethod.jp/articles/bigquery-remote-function-with-natural-language-api/)
