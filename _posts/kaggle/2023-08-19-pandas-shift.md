---
layout: post
title: "pandas shift" 
date: 2023-08-19
excerpt: "pandasのshift関数の使い方"
kaggle: true
tag: ["python", "pandas", "shift"]
comments: false
sort_key: "2023-08-19"
update_dates: ["2023-08-19"]
---

# pandasのshift関数の使い方

## 概要
 - レコードをずらす操作
 - ずらして参照されない値は`NaT`や`null`が入る
   - 値の補完には`bfill`, `ffill`関数が使える
     - `bfill`は後方の有効な値を探して補完
     - `ffill`は前方の有効な値を探して補完

## 具体例

```python
df = pd.DataFrame(dict(
    A=["a", "b", "c"],
    B=[1, 2, 3]
))
df["B+1"] = df["B"].shift(+1).bfill()
display(df)
```

|index|A|B|B+1|
|---|---|---|---|
|0|a|1|1\.0|
|1|b|2|1\.0|
|2|c|3|2\.0|

### groupbyと組み合わせて使用する

```python
df = pd.DataFrame(dict(
    A=["a", "a", "a", "b", "b", "b", "c", "c", "c"],
    B=[1, 2, 3, 11, 12, 13, 21, 22, 23]
))

df["B_A_shift"] = df.groupby("A")["B"].shift(+1).bfill()
display(df)
```

|index|A|B|B\_A\_shift|
|---|---|---|---|
|0|a|1|1\.0|
|1|a|2|1\.0|
|2|a|3|2\.0|
|3|b|11|11\.0|
|4|b|12|11\.0|
|5|b|13|12\.0|
|6|c|21|21\.0|
|7|c|22|21\.0|
|8|c|23|22\.0|

## Google Colab
 - [pandas-shift-bfill-ffill-example](https://colab.research.google.com/drive/1zfh_1Ml1cekaedzlNecKPd3FqV7bybqA?usp=sharing)
