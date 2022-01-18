---
layout: post
title: "Python3 のリダイレクト時におけるUnicodeエラー"
date: 2017-04-03
excerpt: "Python3でもこれに悩まされるとは"
tags: ["python3", "unicode"]
comments: false
---

# 概要
 - `|`(パイプ)や`>`で標準入出力をリダイレクトしてどこかに書き込もうとするとエラーがでることがある
 - 原因は`sys.stdout`がutf8エンコードされていないことに起因する

## sys.stdoutをラップして回避する

```python
sys.stdout = codecs.getwriter("utf-8")(sys.stdout)
```
