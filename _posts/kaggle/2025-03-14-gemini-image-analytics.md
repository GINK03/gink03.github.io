---
layout: post
title: "gemini image analytics"
date: 2025-03-14
excerpt: "gemini image analytics"
kaggle: true
tag: ["gemini", "gpt", "LLM", "python"]
comments: false
sort_key: "2025-03-14"
update_dates: ["2025-03-14"]
---

# gemini image analytics

## 概要
 - geminiでは、画像解析を行うことができる　
 - pdfの分析であっても画像解析を通じての情報抽出が可能


## サンプルコード

```python
from IPython.display import display
from IPython.display import Markdown
import google.generativeai as genai

file1 = genai.upload_file(path="path/01.png")
file2 = genai.upload_file(path="path/02.png")

model = genai.GenerativeModel('gemini-2.0-pro-exp')
response = model.generate_content(["""PDFを画像化したものをお渡しします。
 - こちらの内容をテキストドキュメントに変換してください。
 - 画像は適宜、（画像：画像の説明）で画像の内容をテキストのみで理解できるように十分に補足してください。
 - 出力には余計なことは言わずに、テキストと画像の説明のみでお願いします。
 """, file1, file2])
display(Markdown(response.text))
```
