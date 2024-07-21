---
layout: post
title: "numpy argsort"
date: 2024-07-21
excerpt: "numpy argsort"
project: false
kaggle: true
tag: ["numpy", "python"]
comments: false
sort_key: "2024-07-21"
update_dates: ["2024-07-21"]
---

# numpy argsort

## 概要
 - `np.argsort` は `pd.Series.argsort()` と似ているが、dataframeのindexを返すのではなく、ndarrayのindexを返す

## 具体例

```python
import numpy as np
arr = np.array([1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1])
arr.argsort()
# array([ 0, 10,  1,  9,  2,  8,  3,  7,  4,  6,  5])
sorted_arr = arr[arr.argsort()]
# array([1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6])
```
