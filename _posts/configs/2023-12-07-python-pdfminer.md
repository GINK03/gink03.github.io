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

### pdfから装飾情報つきでテキストを抽出する

```python
import requests
from pdfminer.high_level import extract_pages
from pdfminer.layout import LTTextContainer, LTTextLine, LTChar


def download_pdf(url, save_path):
    response = requests.get(url)
    with open(save_path, 'wb') as f:
        f.write(response.content)


def extract_text_and_styles_from_url(pdf_url):
    temp_pdf_path = "temp_downloaded.pdf"
    download_pdf(pdf_url, temp_pdf_path)
    
    results = []
    current_chunk = {"text": "", "bold": None, "italic": None, "fontname": None, "size": None}

    for page_layout in extract_pages(temp_pdf_path):
        for element in page_layout:
            if isinstance(element, LTTextContainer):
                for text_line in element:
                    if isinstance(text_line, LTTextLine):
                        for character in text_line:
                            if isinstance(character, LTChar):
                                char_info = {
                                    "char": character.get_text(),
                                    "bold": "Bold" in character.fontname,
                                    "italic": "Italic" in character.fontname,
                                    "fontname": character.fontname,
                                    "size": character.size
                                }
                                
                                if (current_chunk["bold"] == char_info["bold"] and 
                                    current_chunk["italic"] == char_info["italic"] and
                                    current_chunk["fontname"] == char_info["fontname"] and
                                    current_chunk["size"] == char_info["size"]):
                                    current_chunk["text"] += char_info["char"]
                                else:
                                    if current_chunk["text"]:
                                        results.append(current_chunk)
                                    current_chunk = {
                                        "text": char_info["char"],
                                        "bold": char_info["bold"],
                                        "italic": char_info["italic"],
                                        "fontname": char_info["fontname"],
                                        "size": char_info["size"]
                                    }
    if current_chunk["text"]:
        results.append(current_chunk)
    
    return results

url = 'https://www.jstage.jst.go.jp/article/iken/33/3/33_33-283/_pdf/-char/ja'  # PDFファイルのURLを指定
text_and_styles = extract_text_and_styles_from_url(url)
# 結果の表示
for item in text_and_styles:
    print(f"Text: {item['text']}, Bold: {item['bold']}, Italic: {item['italic']}, Font: {item['fontname']}, Size: {item['size']}")
```
