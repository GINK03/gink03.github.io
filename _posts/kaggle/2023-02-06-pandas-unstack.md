---
layout: post
title: "pandas unstack"
date: 2023-02-06
excerpt: "pandasのunstackの使い方"
kaggle: true
tag: ["python", "pandas", "unstack", "チートシート"]
comments: false
sort_key: "2023-02-06"
update_dates: ["2023-02-06"]
---

# pandasのunstackの使い方

## 概要
 - `aggregate`関数で得られたmulti-indexを展開してカラムに変換する
   - 挙動としてはpivotに似ている

## 具体例

```python
import pandas as pd

df = pd.DataFrame()
df["date"] = ["2023-01-01", "2023-01-01", "2023-01-02", "2023-01-03"]
df["name"] = ["yamada", "takahashi", "ishikawa", "kobayashi"]
df

"""
| date       | name      |
|:-----------|:----------|
| 2023-01-01 | yamada    |
| 2023-01-01 | takahashi |
| 2023-01-02 | ishikawa  |
| 2023-01-03 | kobayashi |
"""

# aggregateでマルチインデックスで結果を得る
x = df.groupby(by=["date", "name"]).agg(count=("date", "count")).reset_index()
print(x.to_markdown(index=False))

"""
| date       | name      |   count |
|:-----------|:----------|--------:|
| 2023-01-01 | takahashi |       1 |
| 2023-01-01 | yamada    |       1 |
| 2023-01-02 | ishikawa  |       1 |
| 2023-01-03 | kobayashi |       1 |
"""

# マルチインデックスをカラムに変換する

x = df.groupby(by=["date", "name"]).agg(count=("date", "count")).unstack().reset_index()
print(x.to_markdown(index=False))

"""
| ('date', '')   |   ('count', 'ishikawa') |   ('count', 'kobayashi') |   ('count', 'takahashi') |   ('count', 'yamada') |
|:---------------|------------------------:|-------------------------:|-------------------------:|----------------------:|
| 2023-01-01     |                     nan |                      nan |                        1 |                     1 |
| 2023-01-02     |                       1 |                      nan |                      nan |                   nan |
| 2023-01-03     |                     nan |                        1 |                      nan |                   nan |
"""
```

### Google Colab
 - [pandas unstack](https://colab.research.google.com/drive/1MCh50G-av7NkqP5fM0KtKBlD3p8KUi88?usp=sharing)

---

## 参考
 - [pandas.DataFrame.unstack/pandas.pydata.org](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.unstack.html)
