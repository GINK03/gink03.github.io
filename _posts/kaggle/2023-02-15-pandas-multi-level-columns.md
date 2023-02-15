---
layout: post
title: "pandas multi level columns" 
date: 2023-02-16
excerpt: "pandasのmulti level columnsの使い方"
kaggle: true
tag: ["python", "pandas", "multi level columns", "チートシート"]
comments: false
sort_key: "2023-02-16"
update_dates: ["2023-02-16"]
---

# pandasのmulti level columnsの使い方

## 概要
 - aggregateした場合、transposeした場合などにカラム名がmulti levelになることがある
 - multi level columnsはタプルを指定することで列にアクセスできる

## 具体例

```python
import pandas as pd

x = pd.DataFrame({'instance':['first','first','second'],'foo':['a','b','c'], "bar": [1, 2, 3]})
print(x.to_markdown(index=False))

"""
| instance   | foo   |   bar |
|:-----------|:------|------:|
| first      | a     |     1 |
| first      | b     |     2 |
| second     | c     |     3 |
"""

x = x.set_index(['instance','foo']).transpose()
print(x.to_markdown(index=False))

|   ('first', 'a') |   ('first', 'b') |   ('second', 'c') |
|-----------------:|-----------------:|------------------:|
|                1 |                2 |                 3 |
```

### Google Colab
 - [pandas-multilevel-columns](https://colab.research.google.com/drive/1nrHLZ_djmEZpuqBCD8nbnz-wUeJiP2KP?usp=sharing)

---

## 参考
 - [Pandas: Multilevel column names/stackoverflow](https://stackoverflow.com/questions/21443963/pandas-multilevel-column-names)
