---
layout: post
title: "pandas droplevel" 
date: 2024-03-04
excerpt: "pandasのdroplevelの使い方"
kaggle: true
tag: ["python", "pandas", "droplevel"]
comments: false
sort_key: "2024-03-04"
update_dates: ["2024-03-04"]
---

# pandasのdroplevelの使い方

## 概要
 - index, columnがMultiIndexの場合、指定したlevelを削除する
 - groupbyで集計した後に、indexのlevelを削除するのに便利

## サンプル

```python
import pandas as pd

# マルチインデックスのデータフレームを作成
df = pd.DataFrame({
    "a": [1, 2, 3],
    "b": [3, 4, 5],
    "c": ["a", "b", "c"],
    "d": [0.1, 0.2, 0.3],
}).set_index(["a", "b"]).rename_axis(["index_a", "index_b"])

# マルチレベルのcolumnを作成
df.columns = pd.MultiIndex.from_tuples([
    ('c', 'e'), ('d', 'f')
], names=['column_level_1', 'column_level_2'])

display(df)
```

|         | column_level_1 | c |   d |
|         | column_level_2 | e |   f |
| index_a |        index_b |   |     |
|--------:|---------------:|--:|----:|
|       1 |              3 | a | 0.1 |
|       2 |              4 | b | 0.2 |
|       3 |              5 | c | 0.3 |

```python
# index_aを削除
display(df.droplevel("index_a", axis=0))
```

| column_level_1 | c |   d |
| column_level_2 | e |   f |
|        index_b |   |     |
|---------------:|--:|----:|
|              3 | a | 0.1 |
|              4 | b | 0.2 |
|              5 | c | 0.3 |

```python
# column_level_1を削除
display(df.droplevel("column_level_1", axis=1))
```

|         | column_level_2 | e |   f |
| index_a |        index_b |   |     |
|--------:|---------------:|--:|----:|
|       1 |              3 | a | 0.1 |
|       2 |              4 | b | 0.2 |
|       3 |              5 | c | 0.3 |

## 参考
 - [pandas.DataFrame.droplevel](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.droplevel.html)
