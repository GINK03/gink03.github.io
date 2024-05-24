---
layout: post
title: "pandas timestamp isocalendar"
date: 2024-05-25
excerpt: "pandas timestamp isocalendar"
project: false
kaggle: true
hide_from_post: true
tag: ["python", "pandas", "チートシート"]
comments: false
sort_key: "2024-05-25"
update_dates: ["2024-05-25"]
---

# pandas timestamp isocalendar

## 概要
 - pandasのtimestampオブジェクトには、isocalendarメソッドがあり、その年、週、曜日を取得できる

## サンプルコード

```python
ser = pd.to_datetime(pd.Series(["2024-05-05", "2024-05-06", "2024-05-07"]))
ser.dt.isocalendar()
"""
|   year |   week |   day |
|-------:|-------:|------:|
|   2024 |     18 |     7 |
|   2024 |     19 |     1 |
|   2024 |     19 |     2 |
"""
```

```python
# 週の情報を取り出す
weekday_names = {1: '月', 2: '火', 3: '水', 4: '木', 5: '金', 6: '土', 7: '日'}
ser.dt.isocalendar().day.apply(lambda x: weekday_names.get(x))
"""
0    日
1    月
2    火
Name: day, dtype: object
"""
```

## 参考
 - [pandas.Series.dt.isocalendar](https://pandas.pydata.org/docs/reference/api/pandas.Series.dt.isocalendar.html)

