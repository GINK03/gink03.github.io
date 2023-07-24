---
layout: post
title: "python pyheif"
date: "2023-07-24"
excerpt: "pythonのpyheifの使い方"
project: false
config: true
tag: ["python", "画像", "HEIF", "High Efficiency Image Format"]
comments: false
sort_key: "2023-07-24"
update_dates: ["2023-07-24"]
---

# pythonのpyheifの使い方

## 概要
 - iOS、macOSで撮影されたjpeg画像は一般的なjpegと互換性のあるものではなく、独自のHigh Efficiency Image Format (HEIF)というもの
   - opencvやPILで透過的にロードできない
 - pyheifという専用のライブラリでロードする必要がある

## 画像のフォーマットの詳細の確認
 - linuxの場合、fileコマンドで確認できる

```console
$ file "any-iphone.jpeg"
"any-iphone.jpeg": ISO Media, HEIF Image HEVC Main or Main Still Picture Profile
```

## HEIFの画像ファイルをPIL, opencv形式で読み込む

```python
import pyheif
from PIL import Image
import matplotlib.pyplot as plt

# HEIF形式の画像を読み込む
heif_file = pyheif.read('any-iphone.jpeg')  # ファイルが 'heic' の場合
image = Image.frombytes(
    heif_file.mode, 
    heif_file.size, 
    heif_file.data,
    "raw",
    heif_file.mode,
    heif_file.stride,
)

# opencvの形式に変換する場合
opencv_image = np.array(image)[..., ::-1]

plt.imshow(image)
plt.show()
```
