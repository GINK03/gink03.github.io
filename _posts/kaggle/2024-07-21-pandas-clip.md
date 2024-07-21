---
layout: post
title: "pandas clip"
date: 2024-7-21
excerpt: "pandas clip"
project: false
kaggle: true
hide_from_post: true
tag: ["python", "pandas", "チートシート"]
comments: false
sort_key: "2024-07-21"
update_dates: ["2024-07-21"]
---

# pandas clip

## 具体例

```python
pd.Series([-1,0,1,2,3]).clip(0,1)
0    0
1    0
2    1
3    1
4    1
dtype: int64
```
