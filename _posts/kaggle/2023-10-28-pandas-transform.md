---
layout: post
title: "pandas transform"
date: 2023-10-28
excerpt: "pandasのtransform関数の使い方とapplyとの使い分け"
kaggle: true
tag: ["python", "pandas", "transform"]
comments: false
sort_key: "2023-10-28"
update_dates: ["2023-10-28", "2026-04-06"]
---

# pandasのtransform関数の使い方

## 概要
 - 要素やグループに対して、関数を適用する
 - 特に、グループごとに、要素の値を変換する事が多い

## pd.Seriesに対してのtransform

```python
import pandas as pd

df = pd.DataFrame({
    'A': [1, 2, 3, 4],
    'B': [10, 20, 30, 40]
})

df['A'] = df['A'].transform(lambda x: x - df['A'].mean())
df

"""
|index|A|B|
|---|---|---|
|0|-1\.5|10|
|1|-0\.5|20|
|2|0\.5|30|
|3|1\.5|40|
"""
```

## pd.GroupByに対してのtransform

```python
import pandas as pd

df = pd.DataFrame({
    'group': ['A', 'A', 'A', 'B', 'B', 'B'],
    'value': [1, 2, 3, 4, 5, 6]
})

df['rolling_mean'] = df.groupby('group')['value'].transform(lambda x: x.rolling(2).mean())
df
"""
|index|group|value|rolling\_mean|
|---|---|---|---|
|0|A|1|NaN|
|1|A|2|1\.5|
|2|A|3|2\.5|
|3|B|4|NaN|
|4|B|5|4\.5|
|5|B|6|5\.5|
"""
```

## transformとapplyの使い分け

`transform` と `apply` の最大の違いは返り値の形状

 - `transform` は元のDataFrameと同じ行数・インデックスを持つ結果を返す
 - `apply` はグループごとに圧縮された結果を返す

```python
import pandas as pd

df = pd.DataFrame({
    'group': ['A', 'A', 'B', 'B'],
    'value': [1, 3, 2, 4]
})

# apply → グループ数分の行に圧縮される
df.groupby('group')['value'].apply('mean')
# group
# A    2.0
# B    3.0

# transform → 元の行数を維持したまま各行に値が展開される
df.groupby('group')['value'].transform('mean')
# 0    2.0
# 1    2.0
# 2    3.0
# 3    3.0
```

元のDataFrameに新しい列として追加したいときは `transform` を使う

```python
# transformなら直接代入できる
df['group_mean'] = df.groupby('group')['value'].transform('mean')
#   group  value  group_mean
# 0     A      1         2.0
# 1     A      3         2.0
# 2     B      2         3.0
# 3     B      4         3.0
```

`apply` だとインデックスがグループキーになった別Seriesが返るため、元のDataFrameへの代入が素直にできない

| 用途 | 使うべきメソッド |
|---|---|
| グループ平均・合計を元の行に付与したい（特徴量エンジニアリング等） | `transform` |
| グループ内での偏差・正規化（各行 - グループ平均）を計算したい | `transform` |
| グループごとの集計結果そのものが欲しい | `apply` / `agg` |
| 複数列をまたいだ複雑な処理 | `apply` |

`transform` の制約

 - 渡す関数は単一のSeriesを受け取る必要がある
 - `apply` のように複数列をまたいだ処理はできない
 - 返り値は元のグループと同じ長さのスカラーかSeriesでなければならない

## Google Colaboratory
 - [pandas-transform-example](https://colab.research.google.com/drive/1HFimThEy0CP2vhuw_yAXw-XPAZN_mvmL?usp=sharing)
