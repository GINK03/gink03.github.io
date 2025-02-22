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
 - 空白を圧縮するには`re.sub(r"\s{2,}", " ", df.to_markdown())`を使う

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

**tablefmtでフォーマット指定**
```python
print(df.to_markdown(tablefmt="pipe"))
'''
|    | A   |   B |
|---:|:----|----:|
|  0 | a   |   1 |
|  1 | b   |   2 |
|  2 | c   |   3 |
'''

print(df.to_markdown(tablefmt="grid"))
'''
+----+-----+-----+
|    | A   |   B |
+====+=====+=====+
|  0 | a   |   1 |
+----+-----+-----+
|  1 | b   |   2 |
+----+-----+-----+
|  2 | c   |   3 |
+----+-----+-----+
'''
```

## マークダウン形式のデータを読み込む
 - [/python-markdown/](/python-markdown/)を参照

## 参考
 - [pandas.DataFrame.to_markdown](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.to_markdown.html)
