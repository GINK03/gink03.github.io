---
layout: post
title: "pandas dummy" 
date: 2023-06-24
excerpt: "pandasのダミー変数の変換"
kaggle: true
tag: ["python", "pandas", "dummy"]
comments: false
sort_key: "2023-06-24"
update_dates: ["2023-06-24"]
---

# pandasのダミー変数の変換

## 概要
 - 値のダミー変数化、ダミー変数の値化などを行うことができる

## 具体例

### get_dummies関数
 - あるカラムの値をダミー変数化する

```python
df = pd.DataFrame({
    "sns": ["twitter", "facebook", "instagram", "tiktok", "youtube"],
    "follwers": [10000, 100, 100000, 20000, 5000]
})
pd.get_dummies(df["sns"], prefix="sns")
"""
|index|sns\_facebook|sns\_instagram|sns\_tiktok|sns\_twitter|sns\_youtube|
|---|---|---|---|---|---|
|0|0|0|0|1|0|
|1|1|0|0|0|0|
|2|0|1|0|0|0|
|3|0|0|1|0|0|
|4|0|0|0|0|1|
"""
```

### get_dummiesで得られた内容を元のデータセットと結合する

```python
pd.concat([df, pd.get_dummies(df["sns"], prefix="sns").astype(int)], axis=1).drop(columns=["sns"])
"""
|index|follwers|sns\_facebook|sns\_instagram|sns\_tiktok|sns\_twitter|sns\_youtube|
|---|---|---|---|---|---|---|
|0|10000|0|0|0|1|0|
|1|100|1|0|0|0|0|
|2|100000|0|1|0|0|0|
|3|20000|0|0|1|0|0|
|4|5000|0|0|0|0|1|
"""
```

### from_dummies関数
 - ダミー変数を一つのカラムに収まるようにする

```python
df = pd.DataFrame({"sns": ["twitter", "facebook", "instagram", "tiktok", "youtube"]})
dummies = pd.get_dummies(df["sns"], prefix="sns")

pd.from_dummies(dummies, sep="_")
"""
|index|sns|
|---|---|
|0|twitter|
|1|facebook|
|2|instagram|
|3|tiktok|
|4|youtube|
"""
```

## Google Colab
 - [pandas dummy example](https://colab.research.google.com/drive/1L6wnR8IgYnI_5v2Z1Uv3VpbB0bn2ZKd4?usp=sharing)

## 参考
 - [pandas.from_dummies](https://pandas.pydata.org/docs/reference/api/pandas.from_dummies.html#pandas.from_dummies)
