---
layout: post
title: "pandas expanding"
date: 2022-12-15
excerpt: "pandasのexpanding(accumulate operation)について"
kaggle: true
tag: ["python", "pandas", "expanding", "accumulate sum", "チートシート"]
comments: false
sort_key: "2022-12-15"
update_dates: ["2022-12-15"]
---

# pandasのexpanding(accumulate operation)について

## 概要
 - BigQueryなどのstandard SQLで使用できるwindow関数のような使い方ができる
   - `groupby + expanding`で等価な機能があるイメージ
 - 今までの累積和、累積平均などを出す際に便利

## 具体例

### 基本

```python
df = pd.DataFrame({"B": [0, 1, 2, np.nan, 4]})
df.expanding(1).sum()

'''
     B
0  0.0
1  1.0
2  3.0
3  3.0
4  7.0
'''
```

### groupbyと組み合わせる
 - リークを防ぐには時間的に並んだ前提で`shift(+1)`するなどで自分自身の情報を参照しない

```python
df['mean_any_value'] = df.groupby(by='group')['any_value'].apply(lambda x: x.shift(+1).expanding().mean())
```

---

## 参考
 - [pandas.DataFrame.expanding/pydata.org](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.expanding.html)
 - [pandas GroupBy and cumulative mean of previous rows in group/stackoverflow](https://stackoverflow.com/questions/56799202/pandas-groupby-and-cumulative-mean-of-previous-rows-in-group)
