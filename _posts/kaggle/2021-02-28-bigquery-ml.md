---
layout: post
title: "bigquery ml"
date: 2021-02-28
excerpt: "bigquery mlについて"
kaggle: true
hide_from_post: true
tag: ["bigquery", "ml"]
comments: false
sort_key: "2021-02-28"
update_dates: ["2021-02-28"]
---

# bigquery mlについて

## モデルの作り方

```sql
CREATE OR REPLACE MODEL `[BUCKET].[TABLENAME]`
OPTIONS
  (model_type='[MODEL]', labels = ['[LABEL]']) AS
...
# 以降、普通の前処理SQL
```
 - `[BUCKET].[TABLENAME]`にモデルが出力される
 - 線形モデル、決定木などがあり、様々なオプションは公式ドキュメントを参考にすること

## モデルの評価の仕方

```sql
#standardSQL
SELECT
  * #AUC等のパフォーマンス
FROM
  ML.EVALUATE(MODEL '[BUCKET].[TABLENAME]',  ( ... # ここに入力のSQLが入る ) )
```

## モデルの利用の仕方

```sql
#standardSQL
SELECT
  * #AUC等のパフォーマンス
FROM
  ML.PREDICT(MODEL '[BUCKET].[TABLENAME]',  ( ... # ここに入力のSQLが入る ) )
```

## 参考
 - [BigQuery ML のドキュメント](https://cloud.google.com/bigquery-ml/docs/)
