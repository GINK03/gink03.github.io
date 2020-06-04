---
layout: post
title: "snowflake"
date: 2020-06-04
excerpt: ""
tags: [アルゴリズム]
comments: false
---

# snowflake
 - twitterIDのユニーク化をするアルゴリズム
 - 時間に対して昇順になっていることが保証される点がただのハッシュと異なる
 - snowflake自体はリタイアしている模様

## 構造

```
  1  sign bit -- not used, always 0?
 41 bits (milliseconds since epoch) - 1288834974657L
  5  bits datacenter id
  5  bits machine id
 12 bit sequence number
```

## pythonでsnowflakeからUTCに戻す

```python
datetime.datetime.fromtimestamp(((snowflake >> 22)+1288834974657)/1000)
```

## 参考
 - https://github.com/client9/snowflake2time
 - https://github.com/cablehead/python-snowflake
 - https://github.com/twitter-archive/snowflake
