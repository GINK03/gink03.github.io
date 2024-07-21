---
layout: post
title: "pandas argsort"
date: 2024-7-21
excerpt: "pandas argsort"
project: false
kaggle: true
hide_from_post: true
tag: ["python", "pandas", "チートシート"]
comments: false
sort_key: "2024-07-21"
update_dates: ["2024-07-21"]
---

# pandas argsort

## 概要
 - [/numpy-argsort/](/numpy-argsort/) と同様の機能を提供するが、pandasのargsortはdataframeのindexを返す

## 具体例

```python
import pandas as pd

# サンプルデータの作成
df = pd.DataFrame({
    'A': [3, 1, 4, 1],
    'B': [5, 2, 3, 4]
})

print("Original DataFrame:")
display(df)
"""
Original DataFrame:
|   A |   B |
|----:|----:|
|   3 |   5 |
|   1 |   2 |
|   4 |   3 |
|   1 |   4 |
"""

# Seriesを作成
# argsortを使用して並べ替えたインデックスを取得
sorted_indices = df['A'].argsort()

print("\nSorted Indices:")
print(sorted_indices)
"""
Sorted Indices:
0    1
1    3
2    0
3    2
Name: A, dtype: int64
"""

# インデックスを使ってDataFrameを並べ替える
sorted_df = df.iloc[sorted_indices]
print("\nSorted DataFrame:")
print(sorted_df.to_markdown(index=False))
"""
Sorted DataFrame:
|   A |   B |
|----:|----:|
|   1 |   2 |
|   1 |   4 |
|   3 |   5 |
|   4 |   3 |
"""
```
