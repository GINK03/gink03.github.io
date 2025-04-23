---
layout: post
title: "python pypdf"
date: 2025-04-23
excerpt: "python pypdfの使い方"
config: true
tag: ["python", "pypdf"]
comments: false
sort_key: "2025-04-23"
update_dates: ["2025-04-23"]
---

# python pypdfの使い方

## 概要
 - MITライセンス
 - Pure PythonでPDFを操作するためのライブラリ
 
## インストール

```console
$ pip install pypdf
```

## 使い方

### テキストの抽出

```python
from pypdf import PdfReader

reader = PdfReader("sample.pdf")
text = reader.pages[3].extract_text()
print(text)
```

### 画像の抽出(jpeg, png)

```python
from pypdf import PdfReader
from PIL import Image
import io
import os

reader = PdfReader("sample.pdf")
for pageno, page in enumerate(reader.pages, start=1):
    xobj_dict = page["/Resources"].get("/XObject")
    if not xobj_dict:
        continue
    xobjs = xobj_dict.get_object()
    for name, obj in xobjs.items():
        if obj.get("/Subtype") != "/Image":
            continue

        filters = obj.get("/Filter", [])
        # 1) JPEG はそのまま
        if "/DCTDecode" in filters:
            img_bytes = obj.get_data()
            ext = "jpg"

        # 2) FlateDecode (= PNG 相当) は再構築
        elif "/FlateDecode" in filters:
            width  = obj.get("/Width")
            height = obj.get("/Height")
            bpc    = obj.get("/BitsPerComponent")
            cs     = obj.get("/ColorSpace")
            raw    = obj.get_data()

            # カラースペースに応じて Pillow モードを決定
            if   cs == "/DeviceRGB": mode = "RGB"
            elif cs == "/DeviceGray": mode = "L"
            elif cs == "/DeviceCMYK": mode = "CMYK"
            else:                     mode = "RGB"

            # 生データから Pillow Image を再構築
            img = Image.frombytes(mode, (width, height), raw)
            buf = io.BytesIO()
            img.save(buf, format="PNG")
            img_bytes = buf.getvalue()
            ext = "png"

        else:
            # JPEG/FlateDecode 以外はスキップ
            continue

        filename = f"page{pageno}_{name[1:]}.{ext}"
        with open(filename, "wb") as f:
            f.write(img_bytes)
        print(f"Saved {filename}")
```
