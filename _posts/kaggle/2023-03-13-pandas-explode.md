---
layout: post
title: "pandas explode" 
date: 2023-03-13
excerpt: "pandasのexplodeの使い方"
kaggle: true
tag: ["python", "pandas", "explode", "expand"]
comments: false
sort_key: "2023-03-13"
update_dates: ["2023-03-13"]
---

# pandasのexplodeの使い方

## 概要
 - 収められている値がlistのとき、listを展開して新たなデータフレームを作る操作

## 具体例

```python
import pandas as pd
df = pd.DataFrame()
df["a"] = [[1,2,3], [4, 5,6]]
df
```

|index|a|
|---|---|
|0|1,2,3|
|1|4,5,6|

```python
df.explode("a")
```

|index|a|
|---|---|
|0|1|
|0|2|
|0|3|
|1|4|
|1|5|
|1|6|

### Google Colab
 - [pandas-explode-example](https://colab.research.google.com/drive/1_XyqhSgCPzTEC73LZPAXursOJCraGnOZ?usp=sharing)

---

## 参考
 - [pandas.DataFrame.explode/pandas.pydata.org](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.explode.html)
