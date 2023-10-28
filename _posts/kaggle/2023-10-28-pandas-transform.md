---
layout: post
title: "pandas transform" 
date: 2023-10-28
excerpt: "pandasのtransform関数の使い方"
kaggle: true
tag: ["python", "pandas", "transform"]
comments: false
sort_key: "2023-10-28"
update_dates: ["2023-10-28"]
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

## Google Colaboratory
 - [pandas-transform-example](https://colab.research.google.com/drive/1HFimThEy0CP2vhuw_yAXw-XPAZN_mvmL?usp=sharing)
