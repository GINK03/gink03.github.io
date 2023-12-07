---
layout: post
title: "python pdfminer"
date: 2023-12-07
excerpt: "pythonのpdfminderの概要と使い方"
config: true
tag: ["python", "pdfminer"]
comments: false
sort_key: "2023-12-07"
update_dates: ["2023-12-07"]
---

# pythonのpdfminderの概要と使い方

## 概要
 - pdfminerはpdfを解析するためのライブラリ

## インストール

```console
$ pip install pdfminer.six
```

## 使い方

### pdfからテキストを抽出する

```python
import requests
from pdfminer.high_level import extract_text
from io import BytesIO
import re

def extract_text_from_pdf_url(url):
    response = requests.get(url)
    text = extract_text(BytesIO(response.content))
    text = re.sub("\n{1,}", "\n", text)
    text = re.sub("\s{1,}", " ", text)
    return text

url = 'https://www.jstage.jst.go.jp/article/iken/33/3/33_33-283/_pdf/-char/ja'  # PDFファイルのURLを指定
text = extract_text_from_pdf_url(url)
print(text)
```
