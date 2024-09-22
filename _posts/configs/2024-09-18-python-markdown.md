---
layout: post
title: "python markdown"
date: 2024-09-18
excerpt: "python markdownの使い方"
tags: ["python", "markdown", "pandas"]
config: true
comments: false
sort_key: "2024-09-18"
update_dates: ["2024-09-18"]
---

# python markdownの使い方

## 概要
 - markdownをHTMLに変換するライブラリ
 - markdown形式のテーブル情報をHTMLに変換し、pandasのDataFrameに変換することができる

## インストール

```console
$ pip install markdown
```

## 使用例

```python
import markdown
from bs4 import BeautifulSoup
import pandas as pd
from io import StringIO

markdown_text = """
# hello

## this is sample
 - show table below

| Tables        | Are           | Cool  |
| ------------- |-------------| -----|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |
"""

# markdonwをHTMLに変換
html = markdown.markdown(markdown_text, extensions=['markdown.extensions.tables'])

# BeautifulSoupでHTMLを解析
soup = BeautifulSoup(html, 'html.parser')

# pandasのDataFrameに変換
df_list = pd.read_html(StringIO(str(soup)))
df = df_list[0]
df

"""
|    | Tables        | Are           | Cool   |
|---:|:--------------|:--------------|:-------|
|  0 | col 3 is      | right-aligned | $1600  |
|  1 | col 2 is      | centered      | $12    |
|  2 | zebra stripes | are neat      | $1     |
"""
```

