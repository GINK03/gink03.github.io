---
layout: post
title: "python grequests"
date: 2022-10-05
excerpt: "python grequestsの使い方"
config: true
tag: ["python", "grequests"]
comments: false
sort_key: "2022-10-05"
update_dates: ["2022-10-05"]
---

# grequestsの使い方

## 概要
 - pythonのrequestsライブラリのasync版
 - GCPのCloud Runに細かくクエリを刻んで投げるときなどに、便利
   - 並列に投げるとその分インスタンスが立ち上がり、高速化できる

## 具体例

```python
import grequests

urls = [
  'http://www.heroku.com',
  'http://python-tablib.org',
  'http://httpbin.org',
  'http://python-requests.org',
  'http://fakedomain/',
  'http://kennethreitz.com'
]
reqs = (grequests.get(u) for u in urls)

# 並列数が3程度
results = grequests.map(reqs)

# 並列数を指定して実行
results = list(grequests.imap(reqs, size=10))
```

---

## 参考
 - [spyoungtech/grequests](https://github.com/spyoungtech/grequests)
