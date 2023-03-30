---
layout: post
title: "pandas json normalize" 
date: 2023-03-30
excerpt: "pandasのjson normalizeの使い方"
kaggle: true
tag: ["python", "pandas", "json", "json normalize"]
comments: false
sort_key: "2023-03-30"
update_dates: ["2023-03-30"]
---

# pandasのjson normalizeの使い方

## 概要
 - ネストしたjsonをテーブルデータとして変換する関数
 - レコードの単位を指定することもできる
 - `sep`の引数を指定することで`.`以外で結合できる

## 具体例

```python
data = [
    {
        "id": 1,
        "name": "Cole Volk",
        "fitness": {"height": 130, "weight": 60},
    },
    {
        "name": "Mark Reg", 
        "fitness": {"height": 130, "weight": 60}},
    {
        "id": 2,
        "name": "Faye Raker",
        "fitness": {"height": 130, "weight": 60},
    },
]

display(pd.json_normalize(data))
```

|   id | name       |   fitness.height |   fitness.weight |
|-----:|:-----------|-----------------:|-----------------:|
|    1 | Cole Volk  |              130 |               60 |
|  nan | Mark Reg   |              130 |               60 |
|    2 | Faye Raker |              130 |               60 |

---

## 参考
 - [pandas.json_normalize/pandas.pydata.org](https://pandas.pydata.org/docs/reference/api/pandas.json_normalize.html)
