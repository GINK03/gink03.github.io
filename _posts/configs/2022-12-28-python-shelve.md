---
layout: post
title: "python shelve"
date: 2022-12-28
excerpt: "pythonのshelveの使い方"
tags: ["python", "python3", "shelve", "permanent", "dbm"]
config: true
comments: false
sort_key: "2022-12-28"
update_dates: ["2022-12-28"]
---

# pythonのshelveの使い方

## 概要
 - dictの操作性のデータ構造を恒久化するpythonのデフォルトのライブラリ
 - `dbm`と`pickle`で作られているらしい
 - `open`, `close`のオペレーションが必要
   - つまり、マルチプロセスなどには対応しない

## 恒久化のタイミング
 - `=`で値を代入したとき

## 具体例
 - twitterのshort url(t.co)を展開するプログラムの例

```python
import requests
import pandas as pd
import shelve

def reverse_tco(url):
    with shelve.open("dic") as dic:
        if dic.get(url) is None:
            r = requests.head(url)
            location = r.headers.get("Location")
            dic[url] = location # この時点で保存
        location = dic[url]
    return location
```

---

## 参考
 - [shelve — Python object persistence/docs.python.org](https://docs.python.org/3/library/shelve.html)
