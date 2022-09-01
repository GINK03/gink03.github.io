---
layout: post
title: "python datetime" 
date: "2022-08-31"
excerpt: "python datetimeの使い方"
config: true
tag: ["datetime", "python"]
comments: false
sort_key: "2022-08-31"
update_dates: ["2022-08-31"]
---

# python datetimeの使い方

## 概要
 - [ISO8601(RFC3339)](https://qiita.com/estaro/items/2b7074839d2a5e883dc1)という企画がある
   - UTCの例 
     - `YYYY-mm-ddTHH:MM:SSZ`
     - `YYYY-mm-ddTHH:MM:SS+00:00:`
   - JSTの例
     - `YYYY-mm-ddTHH:MM:SS+09:00`
 - ISO8601に適合した出力を得るには、`.isoformat()`関数が必要
   - デフォルトでは`microseconds`まで表示されるので、`timespec="seconds"`まで表示される

## 具体例

```python
import datetime
import pytz

dt = datetime.datetime.now()

# pythonデフォルトのisoformat
print(dt.isoformat()) # 2022-08-31T04:45:33.576946

# UTCでISO8601を適応した例
# JavaScript互換なので、開発時には便利
# システムのTZが優先されることもあり、使用に注意が必要
print(dt.strftime("%Y-%m-%dT%H:%M:%SZ")) # 2022-08-31T04:45:33Z

# JSTでISO8601を適応した例
jst_dt = dt.astimezone(pytz.timezone('Asia/Tokyo'))
print(jst_dt.isoformat()) # 2022-08-31T13:32:50.675778+09:00

# secondsでオフセットをつけて、インラインで時刻の誤解がなく、文字列として出力する
print(datetime.datetime.now().astimezone(pytz.timezone("UTC")).isoformat(timespec='seconds')) # 2022-09-01T06:18:11+00:00 (日本時間の15:18に実行)
```

### 注意点 
 - `strftime`で出力される値はタイムゾーンが設定されている場合は暗黙的にそのタイムゾーンの出力になる
   - つまり、`dt.strftime("%Y-%m-%dT%H:%M:%SZ")`は場合によっては期待した動作をしない
   - `isoformat()`で得られた文字列を加工するほうが安全

### Google Colab
 - [python-datetime-iso8601](https://colab.research.google.com/drive/1eiEDlM8GFyYjUYhadz9P6qRnAeF3GLbl?usp=sharing)

## 参考
 - [PythonでISO8601(RFC3339)を扱う/Qiita](https://qiita.com/estaro/items/2b7074839d2a5e883dc1)
 - [日時のフォーマット（ISO 8601）/Qiita](https://qiita.com/kidatti/items/272eb962b5e6025fc51e)
 - [Pythonの UTC ⇔ JST、文字列(UTC) ⇒ JST の変換とかのメモ/Qiita](https://qiita.com/yoppe/items/4260cf4ddde69287a632)

