---
layout: post
title: "pandas markdown"
date: 2022-10-12
excerpt: "pandasのmarkdownについて"
kaggle: true
tag: ["python", "pandas", "markdown", "チートシート"]
comments: false
sort_key: "2022-10-12"
update_dates: ["2022-10-12"]
---

# pandasのmarkdownについて

## 概要
 - jupyterなどでdataframeを表示したとき、デフォルトではHTMLで、tab or space区切りになっている
   - markdownの書類に転記する際に変換が面倒
 - markdownフォーマットで直接出力可能

## マークダウンフォーマットで表示する

```python
import pandas as pd

df = pd.DataFrame()
df["A"] = ["a", "b", "c"]
df["B"] = [1, 2, 3]
print(df.to_markdown(index=False))

'''
| A   |   B |
|:----|----:|
| a   |   1 |
| b   |   2 |
| c   |   3 |
'''
```

## 参考
 - [pandas.DataFrame.to_markdown](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_markdown.html)
