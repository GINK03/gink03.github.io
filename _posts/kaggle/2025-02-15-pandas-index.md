---
layout: post
title: "pandas index" 
date: 2025-02-15
excerpt: "pandas index"
kaggle: true
tag: ["pandas"]
comments: false
sort_key: "2025-02-15"
update_dates: ["2025-02-15"]
---

# pandas index

## 概要
 - pandasのindexについて

## 具体例

**indexに名前をつける**

```python
df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
df.index.name = 'index_name'
df
"""
|   index_name |   A |   B |
|-------------:|----:|----:|
|            0 |   1 |   4 |
|            1 |   2 |   5 |
|            2 |   3 |   6 |
"""
```

**マルチレベルのindex**

```python
df = pd.DataFrame({'A': [1, 2, 3], 'B': [4, 5, 6]})
df = df.set_index("A", append=True)
df
"""
|        |   B |
|:-------|----:|
| (0, 1) |   4 |
| (1, 2) |   5 |
| (2, 3) |   6 |
"""
```

**マルチレベルindexの特定のレベルを取り出す**

```python
df.index = df.index.get_level_values(1)
df
"""
|   A |   B |
|----:|----:|
|   1 |   4 |
|   2 |   5 |
|   3 |   6 |
"""
```
