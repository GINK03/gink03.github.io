---
layout: post
title: "python trafilatura"
date: 2025-08-25
excerpt: "python trafilaturaの使い方"
config: true
tag: ["python", "trafilatura"]
comments: false
sort_key: "2025-08-25"
update_dates: ["2025-08-25"]
---

# python trafilatureの使い方

## 概要
 - `trafilatura`は、ウェブページからテキストを抽出するためのPythonライブラリ
 - テキスト密度（text density）、リンク密度（link density）、タグ分析（tag analysis）を使って、本文エリアを特定
 - 読み方はイタリア風に「トラフィラトゥーラ」

## インストール

```console
$ pip install trafilatura
```

## 使い方

```python
import trafilatura
downloaded = trafilatura.fetch_url('https://example.com/')
result = trafilatura.extract(downloaded)
```
