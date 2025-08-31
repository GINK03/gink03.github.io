---
layout: post
title: "python pdf2image"
date: 2025-08-31
excerpt: "python pdf2imageの使い方"
config: true
tag: ["python", "pdf2image", "pdf"]
comments: false
sort_key: "2025-08-31"
update_dates: ["2025-08-31"]
---

# python pdf2imageの使い方

## 概要
 - PDFを画像に変換するためのシンプルな方法
 - 画像化したあとにBase64へ変換してAPIに渡すなどの用途に便利

## インストール

**依存 (Linux)**
```console
$ sudo apt install poppler-utils
```

**依存 (macOS)**
```console
$ brew install poppler
```

**インストール**
```console
$ pip install pdf2image
```

## 使い方

```python
from pdf2image import convert_from_path
from io import BytesIO
import base64

# DPIやフォーマットを指定して読み込み（デフォルトはDPI=200程度）
images = convert_from_path(
    'data/sample.pdf',
    dpi=200
)

# 画像をbase64に変換
base64_images = []
for img in images:
    buffered = BytesIO()
    img.save(buffered, format="PNG")
    img_str = base64.b64encode(buffered.getvalue()).decode('utf-8')
    base64_images.append(img_str)
```

**バイト列から直接変換**

```python
from pdf2image import convert_from_bytes

with open('data/sample.pdf', 'rb') as f:
    pdf_bytes = f.read()

images = convert_from_bytes(pdf_bytes, dpi=200)
```
