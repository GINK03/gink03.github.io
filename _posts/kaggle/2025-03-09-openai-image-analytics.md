---
layout: post
title: "openai image analytics" 
date: 2025-03-09
excerpt: "openai image analytics"
kaggle: true
tag: ["openai", "image", "analytics"]
comments: false
sort_key: "2025-03-09"
update_dates: ["2025-03-09"]
---

# openai image analytics


## 概要
 - openaiを用いた画像解析の方法について記載
 - 画像はbase64形式でAPIに渡す
 - pdfを解析する際にも利用可能


## 具体例

```python
from pdf2image import convert_from_path
from pdf2image.exceptions import (
    PDFInfoNotInstalledError,
    PDFPageCountError,
    PDFSyntaxError
)
from pdfminer.high_level import extract_text
import base64
import io
import numpy as np

def convert_doc_to_images(path, max_width=800, max_height=800):
    images = convert_from_path(path)
    return images

def extract_text_from_doc(path):
    text = extract_text(path)
    return text

def get_img_uri(img):
    png_buffer = io.BytesIO()
    img.save(png_buffer, format="PNG")
    png_buffer.seek(0)

    base64_png = base64.b64encode(png_buffer.read()).decode('utf-8')

    data_uri = f"data:image/png;base64,{base64_png}"
    return data_uri

system_prompt = '''
## 目的
 - PDFの書類の一部を画像化したものを渡します。
 - PDFと一般的なレポートは情報量的に同じであり、レポートをテキストのみで作成します
 - PDFの画像の書類を渡すので、それをレポート上にしてください

## 制限
 - レポートはマークダウンであり画像をいれることができないので、画像を解析し、適切に十分な情報量を持って言語にて説明してください。
 - エンドユーザはレポートのみしか見れないので画像やイラストレーションを十分に言葉だけで伝わるように伝える必要があります。
 - 出力はすべて日本語
'''

def analyze_image(data_uris):
    client = OpenAI()
    response = client.chat.completions.create(
        model="gpt-4o",
        messages=[
            {"role": "system", "content": system_prompt},
            {
                "role": "user",
                "content": [
                    { "type": "image_url", "image_url": { "url": f"{data_uri}" } }
                    for data_uri in data_uris
                ]
                },
        ],
        temperature=0,
        top_p=0.1
    )
    return response.choices[0].message.content

file_path = "data/yourfile.pdf"
images = convert_doc_to_images(file_path)
data_uris = [get_img_uri(img) for img in images]

tmp = []
for chunk in tqdm(np.array_split(data_uris, len(data_uris) // 3)):
    res = analyze_image(chunk)
    tmp.append(res)
```
