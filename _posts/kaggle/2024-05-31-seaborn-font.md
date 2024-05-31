---
layout: post
title: "seaborn font"
date: 2024-05-31
excerpt: "seaborn font"
tags: ["seaborn", "python", "matplotlib", "可視化"]
kaggle: true
comments: false
sort_key: "2024-05-31"
update_dates: ["2024-05-31"]
---

# seaborn font

## Windowsで日本語フォントを使う

```python
import matplotlib.pyplot as plt
import seaborn as sns
import os

if os.name == 'nt':
    sns.set(font='Yu Gothic')
```
