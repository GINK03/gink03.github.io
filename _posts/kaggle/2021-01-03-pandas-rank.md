---
layout: post
title: "pandas rank"
date: 2021-01-03
excerpt: "pandas rankのチートシート"
tag: ["python", "pandas", "チートシート"]
kaggle: true
sort_key: "2022-05-30"
update_dates: ["2022-05-30"]
comments: false
---

# pandas rankのチートシート

## 概要
 - ランク関数
   - `method`
     - `average`, `min`, `max`, `first`, `dense`などランク方法を指定
   - `na_option`
     - NaNをどうするか
     - `keep`; そのまま無視する
   - `pct`
     - `0.0 ~ 1.0`に圧縮する
   - `ascending`
     - `True`で昇順、`False`で降順


## methodによる挙動の違い

### dense

```python
pd.Series([1,2,2,3]).rank(method="dense")
0    1.0
1    2.0
2    2.0
3    3.0
```

### average

```python
pd.Series([1,2,2,3]).rank(method="average")
0    1.0
1    2.5
2    2.5
3    4.0
```

### first
 - 同じ値であれば最初に出現したレコードが高い順位になる
 - トータルで100%にしたいときなどがユースケースになる

```python
pd.Series([1,2,2,3]).rank(method="first")
0    1.0
1    2.0
2    3.0
3    4.0
```

## `pct(percentile)`オプション
 - `0.0 ~ 1.0`に圧縮するオプション
 - `method="first"`と組み合わせると、`0.0 ~ 1.0`に埋め込める

## 参考
 - [pandas.DataFrame.rank¶](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.rank.html)
