---
layout: post
title: "pandas memory"
date: 2022-10-18
excerpt: "pandasのmemoryについて"
kaggle: true
tag: ["python", "pandas", "memory", "チートシート"]
comments: false
sort_key: "2022-10-18"
update_dates: ["2022-10-18"]
---

# pandasのmemoryについて

## 概要
 - pandasのデータ型を小さいデータを指定して読み込むことでメモリの使用量を削減できる
 - `memory_usage()`で、カラムごとの使用メモリを確認することもできる

<div>
  <img src="https://miro.medium.com/max/1188/1*fsEpwfWQBMnaC6iISieHOw.png">
</div>

## 具体例
 - メモリの使用量を外部ファイルで指定して、csvで読み込む
 - カラムごとのメモリを表示

```python
dtypes = pd.read_csv('dtypes.csv')
dtypes_dict = {k: v for (k, v) in zip(dtypes["col_name"], dtypes["dtype"])}
# データ型を指定して読み込み
df = pd.read_csv('data.csv', dtype=dtypes_dict)

# カラムごとのメモリをMb単位で表示
memory = df.memory_usage().to_frame().reset_index()
memory.columns = ["col_name", "memory[Mb]"]
memory["memory[Mb]"] /= 1024**2
memory
```

## 参考
 - [Reducing memory usage in pandas with smaller datatypes](https://towardsdatascience.com/reducing-memory-usage-in-pandas-with-smaller-datatypes-b527635830af)
 - [pandas.DataFrame.memory_usage](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.memory_usage.html)
