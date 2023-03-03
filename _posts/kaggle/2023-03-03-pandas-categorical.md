---
layout: post
title: "pandas categorical" 
date: 2023-03-03
excerpt: "pandasのcategoricalな変数の扱い方"
kaggle: true
tag: ["python", "pandas", "categorical", "one-hot encoding", "チートシート"]
comments: false
sort_key: "2023-03-03"
update_dates: ["2023-03-03"]
---

# pandasのcategoricalな変数の扱い方

## 概要
 - pandasにはカテゴリ型が存在する
   - `astype("category")`とすればよい
 - 面倒なワンホットエンコーディングにもデフォルトの機能として含まれる

## 具体例

### seriesをcategory変数にして数字のインデックスを振る

```python
s = pd.Series(["a", "b", None, "c"])
s = s.astype("category") #カテゴリ型に変換
print(s) # Categories (3, object): ['a', 'b', 'c']
# 数値のindexに変換
print(s.cat.codes)
"""
0    0
1    1
2   -1
3    2
"""
```

### ワンホットエンコーディングしてダミー変数を得る

```python
df = pd.DataFrame()
df["自転車の種類"] = ["ママチャリ", "ピスト", "クロス", "グラベル", "ロード"]
df["重さ"] = ["重い", "軽い", "普通", "普通", "軽い"]
res = pd.get_dummies(df, columns=["自転車の種類"], prefix=["type_is"])
display(res)
```

|index|重さ|type\_is\_クロス|type\_is\_グラベル|type\_is\_ピスト|type\_is\_ママチャリ|type\_is\_ロード|
|---|---|---|---|---|---|---|
|0|重い|0|0|0|1|0|
|1|軽い|0|0|1|0|0|
|2|普通|1|0|0|0|0|
|3|普通|0|1|0|0|0|
|4|軽い|0|0|0|0|1|

### Google Colab
 - [pandas-category-examples](https://colab.research.google.com/drive/1oOQ4858mMZUUuelZ3jYDYfvGjT4ag5Pa?usp=sharing)

