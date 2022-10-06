---
layout: post
title: "pandas melt"
date: 2022-10-05
excerpt: "pandas meltのチートシート"
kaggle: true
tag: ["python", "pandas", "melt", "チートシート"]
sort_key: "2022-10-05"
update_dates: ["2022-10-05"]
comments: false
---

# pandas meltのチートシート

## 概要
 - pivotの逆の操作の関数
 - イメージとして横に広いテーブルを縦に長いテーブルに変換する

## 具体例

```python
example = [["date", "twitter", "youtube", "tiktok"],
           ["a", "10", "10", "0"],
           ["b", "100", "20", "50"],
           ["c", "1000", "50", "1000"]]
import pandas as pd
df = pd.DataFrame(example[1:])
df.columns = example[0]
```

|    | date   |   twitter |   youtube |   tiktok |
|---:|:-------|----------:|----------:|---------:|
|  0 | a      |        10 |        10 |        0 |
|  1 | b      |       100 |        20 |       50 |
|  2 | c      |      1000 |        50 |     1000 |

このようなデータがある時、`twitter`, `youtube`, `tiktok`のカラム名をバリューにして縦に長くする

```python
df_melt = pd.melt(df, id_vars=["date"], value_vars=["twitter", "youtube", "tiktok"]).sort_values(by=["date"])
print(df_melt.to_markdown())
```

|    | date   | variable   |   value |
|---:|:-------|:-----------|--------:|
|  0 | a      | twitter    |      10 |
|  3 | a      | youtube    |      10 |
|  6 | a      | tiktok     |       0 |
|  1 | b      | twitter    |     100 |
|  4 | b      | youtube    |      20 |
|  7 | b      | tiktok     |      50 |
|  2 | c      | twitter    |    1000 |
|  5 | c      | youtube    |      50 |
|  8 | c      | tiktok     |    1000 |

#### Google Colab
 - [pandas-melt-example](https://colab.research.google.com/drive/1bYs7-Gnkub3d25DCH04zvTFQibjAtMW8?usp=sharing)

---

## 参考
 - [pandas.melt](https://pandas.pydata.org/docs/reference/api/pandas.melt.html)
