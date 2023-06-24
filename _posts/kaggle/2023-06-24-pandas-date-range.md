---
layout: post
title: "pandas date_range" 
date: 2023-06-24
excerpt: "pandasのdate_rangeの変換"
kaggle: true
tag: ["python", "pandas", "datetime", "date range", "date_range"]
comments: false
sort_key: "2023-06-24"
update_dates: ["2023-06-24"]
---

# pandasのdate_rangeの変換

## 概要
 - `start`と`end`の情報を与えて、一定の粒度の時間の値を作る関数
 - オプション
   - `freq`
     - `<n>D`, `<n>W`, `<n>M`の粒度で設定できる
   - `inclusive`
     - `both`
       - `start`と`end`の境界を含む
     - `neither`
       - `start`と`end`の境界を含まない

## 具体例

### dailyの粒度で作る

```python
pd.date_range(start="2020-11-06", end="2021-11-06", freq="D")
"""
DatetimeIndex(['2020-11-06', '2020-11-07', '2020-11-08', '2020-11-09',
               '2020-11-10', '2020-11-11', '2020-11-12', '2020-11-13',
"""
```

### weeklyの粒度で作る

```python
pd.date_range(start="2020-11-06", end="2021-11-06", freq="W")
"""
DatetimeIndex(['2020-11-08', '2020-11-15', '2020-11-22', '2020-11-29',
               '2020-12-06', '2020-12-13', '2020-12-20', '2020-12-27',
"""
```

### monthlyの粒度で作る

```python
pd.date_range(start="2020-11-06", end="2021-11-06", freq="M")
"""
DatetimeIndex(['2020-11-30', '2020-12-31', '2021-01-31', '2021-02-28',
               '2021-03-31', '2021-04-30', '2021-05-31', '2021-06-30',
"""
```


### monthlyの粒度でオフセットを指定して作る

```python
pd.date_range(start='2022-01-01', periods=12, freq=pd.offsets.MonthEnd(1))
"""
DatetimeIndex(['2022-01-31', '2022-02-28', '2022-03-31', '2022-04-30',
               '2022-05-31', '2022-06-30', '2022-07-31', '2022-08-31',
"""
```

## Google Colab
 - [pandas date_range](https://colab.research.google.com/drive/1WW_R-Rj9cs5oO-OcS7BOxgV5ZOJb2BOi?usp=sharing)

## 参考
 - [pandas.date_range/pandas.pydata.org](https://pandas.pydata.org/docs/reference/api/pandas.date_range.html)
