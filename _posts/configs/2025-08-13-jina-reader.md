---
layout: post
title: "jina reader"
date: "2025-08-13"
excerpt: "jina readerの使い方"
config: true
tags: ["jina-reader", "jina", "reader", "python"]
comments: false
sort_key: "2025-08-13"
update_dates: ["2025-08-13"]
---

# jina-readerの使い方

## 概要
 - 深層学習ベースのhtml -> markdown変換ツール
 - 一部無料(apiキーなし)でも利用可能

## 使用例

```python
from IPython.display import Markdown
import requests
	# 必要に応じて APIキーを設定
	api_key = ""  # YOUR_API_KEY
	
	# Authorization ヘッダーなしでも動作します
	headers = {}
	# APIキーを利用する場合は以下のコメントを外してください
	# headers["Authorization"] = f"Bearer {api_key}"
	# headers["Accept"] = "application/json"  # JSON形式で詳細な情報を取得する場合

target_url = "https://www3.nhk.or.jp/news/"
url = f"https://r.jina.ai/{target_url}"
response = requests.get(url, headers=headers)
Markdown(response.text)
# (ウェブサイトの内容をMarkdown形式で取得し、表示)
```

## 参考
 - [https://jina.ai](https://jina.ai/)
