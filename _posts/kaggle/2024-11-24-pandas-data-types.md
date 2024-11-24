---
layout: post
title: "pandas data types" 
date: 2024-11-24
excerpt: "pandas data typesの種類"
kaggle: true
tag: ["pandas"]
comments: false
sort_key: "2024-11-24"
update_dates: ["2024-11-24"]
---

# pandas data typesの種類

## 概要
 - 拡張データタイプとして`pd.Int64Dype`や`pd.Float64Dtype`などがある
   - `np.nan`が含まれると、intではなくfloatになる問題があったが、これを解決するために導入された
   - 拡張データタイプにおけるnullは`pd.NA`で表現される


## 拡張データタイプ
 - `pd.Int8Dtype ~ pd.Int64Dtype`
 - `pd.UInt8Dtype ~ pd.UInt64Dtype`
 - `pd.Float16Dtype ~ pd.Float64Dtype`
 - `pd.BooleanDtype`
 - `pd.StringDtype`
 - `pd.CategoricalDtype`


## 使用例

```python
df = pd.DataFrame(
    {
        "a": [1, 2, None],
        "b": ["aaa", None, "ccc"],
        "c": [None, 'B', 'C'],
    }
)
df['a'] = df['a'].astype('Int64') # pd.Int64Dtype()に変換
df['b'] = df['b'].astype('string') # pd.StringDtype()に変換
df['c'] = df['c'].astype(pd.CategoricalDtype()) # pd.CategoricalDtype()に変換(Noneはpd.NAに変換されない)
df
```

## 参考
 - [pandas arrays, scalars, and data types - pandas.pydata.org](https://pandas.pydata.org/docs/reference/arrays.html)
