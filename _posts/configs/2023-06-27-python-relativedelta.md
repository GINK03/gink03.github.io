---
layout: post
title: "python relativedelta(dateutil)"
date: 2023-06-27
excerpt: "pythonのrelativedelta(detautil)の使い方"
config: true
tag: ["python", "deteutil", "relativedelta"]
comments: false
sort_key: "2023-06-27"
update_dates: ["2023-06-27"]
---

# pythonのrelativedelta(dateutil)の使い方

## 概要
 - dateutilという外部パッケージに、relativedeltaという機能がある
 - `datetime`の`timedelta`には`seconds`, `hours`, `days`の粒度はあるが、`months`, `years`, `weekdays`の粒度はない
   - これらの不足を補う側面で`relativedelta`という機能が使える

## インストール

**pip**
```console
$ pip install python-dateutil
```

## 具体例

### ２つの日時の差を知る

```python
import datetime
from dateutil.relativedelta import relativedelta

relativedelta(datetime.datetime.now(), datetime.date(2020, 11, 6))
"""
relativedelta(years=+4, months=+2, days=+30, hours=+16, minutes=+22, seconds=+46, microseconds=+187582)
"""
```

### 次の特定の曜日の日を知る

```python
# 次の金曜日を知る
datetime.datetime.now() + relativedelta(weekday=calendar.FRIDAY)
"""
datetime.datetime(2023, 6, 30, 4, 6, 0, 971181)
"""
```

### xヶ月後の日時を知る

```python
# 一ヶ月後を知る(+30daysとかでは２月は日数が少ないのでうまく行かないが, relativedeltaを用いると計算できる)
datetime.date(2023, 2, 15) + relativedelta(months=1)
"""
datetime.date(2023, 3, 15)
"""
```

## Google Colab
 - [dateutil-relativedelta-example](https://colab.research.google.com/drive/1Y9VMCeRW88HL3bbF87Qhi43Uttv3s4Qa?usp=sharing)

## 参考
 - [relativedelta/dateutil.readthedoc.io](https://dateutil.readthedocs.io/en/stable/relativedelta.html)
