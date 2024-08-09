---
layout: post
title: "python markdownify"
date: 2024-08-09
excerpt: "python markdownifyの使い方"
tags: ["python", "markdown", "markdownify"]
config: true
comments: false
sort_key: "2024-08-09"
update_dates: ["2024-08-09"]
---

# python markdownifyの使い方

## 概要
 - HTMLをMarkdownに変換するライブラリ

## インストール

```console
$ pip install markdownify
```

## オプション
 - `heading_style` - 見出しのスタイルを指定
   - `ATX` - `#`で見出しを表現
   - `SETEXT` - `=`や`-`で見出しを表現
 - `strip` - HTMLタグを削除するかどうか

## 使用例

```python
from markdownify import markdownify as md

html_content = """
<h1>Welcome to My Website</h1>
<p>This is a sample paragraph with <a href="https://example.com">a link</a> and some <strong>bold text</strong>.</p>
"""

# Convert HTML to Markdown
markdown_content = md(html_content, heading_style="ATX")

print(markdown_content)
"""
# Welcome to My Website


This is a sample paragraph with [a link](https://example.com) and some bold text.
"""
```

## 参考
 - [GitHub - matthewwithanm/python-markdownify](https://github.com/matthewwithanm/python-markdownify)
