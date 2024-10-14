---
layout: post
title: "timezone aware"
date: 2024-10-14
excerpt: "timezone awareについて"
computer_science: true
tag: ["timezone aware", "timezone"]
comments: false
sort_key: "2024-10-14"
update_dates: ["2024-10-14"]
---

# timezone awareについて

## 概要
 - タイムスタンプの時刻情報にタイムゾーン情報を付与すること
 - 例えば `UTC` で`2024-10-14 03:25:15`というタイムスタンプがあるとする
   - この時、`Asia/Tokyo` のタイムゾーン情報を付与すると`2024-10-14 12:25:15+09:00` となる

## pythonでタイムスタンプを作成する例

```python
import pandas as pd
from datetime import datetime
from zoneinfo import ZoneInfo

current_ts = pd.Timestamp(datetime.now(ZoneInfo("Asia/Tokyo")))
df = pd.DataFrame()
df["ts"] = [current_ts] * 3
df["action"] = ["a", "b", "c"]
df
"""
|    | ts                               | action   |
|---:|:---------------------------------|:---------|
|  0 | 2024-10-14 11:44:56.727537+09:00 | a        |
|  1 | 2024-10-14 11:44:56.727537+09:00 | b        |
|  2 | 2024-10-14 11:44:56.727537+09:00 | c        |
"""
```
