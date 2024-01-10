---
layout: post
title: "python japan holiday"
date: 2024-01-10
excerpt: "python japan holiday(holiday_jp)の使い方"
project: false
config: true
tag: ["python", "japan holiday", "holiday_jp"]
comments: false
sort_key: "2024-01-10"
update_dates: ["2024-01-10"]
---

# python japan holiday(holiday_jp)の使い方

## 概要
 - pythonで日本の祝日を取得するライブラリ
 - [holiday-jp](https://github.com/holiday-jp/holiday_jp/blob/master/holidays.yml)を元にしている
   - pythonのライブラリでは祝日名が取得できないので、詳細は元のymlファイルを参照する必要がある
 
## インストール

```console
$ pip install holiday_jp
```

## 使い方

**祝日かどうかを判定**
```python
from holiday_jp import HolidayJp
import pandas as pd

def check_is_holiday(date: str) -> bool:
    if HolidayJp(date).is_holiday:
        return True
    elif not HolidayJp(date).is_business_day: # business_dayは月 ~ 金
        return True
    return False

df = pd.DataFrame()
df["date"] = pd.date_range(start="2024-01-01", end="2024-12-31", freq="D")
df["is_holiday"] = df["date"].apply(check_is_holiday)
with pd.option_context("display.max_rows", None, "display.max_columns", None):
    display(df.head(50))
```

## 参考
 - [holiday_jp-python - github](https://github.com/holiday-jp/holiday_jp-python/)

