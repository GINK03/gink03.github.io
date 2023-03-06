---
layout: post
title: "pandas plot" 
date: 2023-03-06
excerpt: "pandasのplotの使い方"
kaggle: true
tag: ["python", "pandas", "plot"]
comments: false
sort_key: "2023-03-06"
update_dates: ["2023-03-06"]
---

# pandasのplotの使い方

## 概要
 - 簡単な可視化であればpandasのplot関数で行える

## pandas.DataFrame.plot.bar
 - `x`; 当てなければindexが使用される
 - `y`; Y軸の値
 - `rot`; X軸のラベルの回転

```python
df = pd.DataFrame({'lab':['A', 'B', 'C'], 'val':[10, 30, 20]})
ax = df.plot.bar(x='lab', y='val', rot=90)
```

---

## 参考
 - [pandas.DataFrame.plot/pandas.pydata.org](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.plot.html)
