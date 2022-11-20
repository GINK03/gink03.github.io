---
layout: post
title: "bigquery unnest"
date: 2022-09-20
excerpt: "bigquery unnestのチートシート"
tags: ["bq", "bigquery", "gcp"]
kaggle: true
comments: false
sort_key: "2022-09-20"
update_dates: ["2022-09-20"]
---

# bigquery unnestのチートシート

## 概要
 - 複雑にネストされた情報は`UNNEST`でアクセスできる
   - ネストとは値が`List[Dict[str, Any]]`のような構造
 - アクセスするときは、FROM句のあとに特定の記法で記す必要がある
   - `UNNEST(table, col_name)`とする

## ネストされるデータ構造
### struct
 - bigqueryはレコードの中にレコードが入っている状態
 - structをunnestするには`struct名.*`でアクセスする

### array
 - arrayをunnestするにはselect句外で`UNNEST`する


## 具体例

```sql
SELECT
  user_id,
  x.key,
FROM 
  `xxx.yyy.zzz`, 
  UNNEST(`xxx.yyy.zzz`, nested_list_col) AS x
GROUP BY
  user_id, 
  x.key
ORDER BY
  user_id
```

---

## 参考
 - [How to query from a table with a list of dictionaries, only for certain keys (BigQuery) SQL](https://stackoverflow.com/questions/69654372/how-to-query-from-a-table-with-a-list-of-dictionaries-only-for-certain-keys-bi)
