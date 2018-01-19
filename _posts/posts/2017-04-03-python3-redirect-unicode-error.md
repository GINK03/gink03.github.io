---
layout: post
title: "Python3 のリダイレクト時におけるUnicodeエラー"
date: 2017-04-03
excerpt: "Python3でもこれに悩まされるとは"
tags: []
comments: false
---

# sys.stdoutをラップして回避する
```python
sys.stdout = codecs.getwriter("utf-8")(sys.stdout)
```
