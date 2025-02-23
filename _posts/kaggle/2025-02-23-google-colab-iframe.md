---
layout: post
title: "google colab iframe"
date: 2025-02-23
excerpt: "google colabでiframeを使う方法"
tags: ["jupyter", "google colab", "colab"]
kaggle: true
comments: false
sort_key: "2025-02-23"
update_dates: ["2025-02-23"]
---

# google colabでiframeを使う方法

## 概要
 - google colabでは読み込むサイトが 以下の制約がなければ、iframeで読み込むことができる
   - ヘッダーで `X-Frame-Options: DENY` が設定
   - ヘッダーで `X-Frame-Options: SAMEORIGIN` が設定

## 具体例

```python
from IPython.display import IFrame
IFrame('https://www3.nhk.or.jp/news/', width=700, height=400)
```
