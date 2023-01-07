---
layout: post
title: "pandas from_dict"
date: 2023-01-07
excerpt: "pandasのdictからdataframeの変換について"
kaggle: true
tag: ["python", "pandas", "dict", "orient", "チートシート"]
comments: false
sort_key: "2023-01-07"
update_dates: ["2023-01-07"]
---

# pandasのdictからdataframeの変換について

## 概要
 - pythonのdict型からdataframeの変換は暗黙的に変換される例とorientを指定しなければ行けない例がある

## dictのkeyがindexと考えれるとき
 - `orient="index"`を指定

```python
data = {"a": 1, "b": 2, "c": 3}
df = pd.DataFrame.from_dict(data, orient="index")
df
"""
	0
a	1
b	2
c	3
"""
```

## dictのkeyがcolumnと考えられるとき
 - `orient="columns"`は省略可能

```python
data = {"word": ["a", "b", "c"], "freq": [1, 2, 3]}
df = pd.DataFrame.from_dict(data, orient="columns") # columnsは省略可能
df
"""
	word	freq
0	a	1
1	b	2
2	c	3
"""
```

## 参考
 - [pandas.DataFrame.from_dict/pandas.pydata.org](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.from_dict.html)
