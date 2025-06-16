---
layout: post
title: "jupyter display images"
date: 2023-11-18
excerpt: "jupyter display images"
tag: ["jupyter", "kaggle", "python"]
comments: false
sort_key: "2023-11-18"
update_dates: ["2023-11-18"]
---

# jupyter display images

## 概要
 - jupyterで画像を表示する方法

## 標準機能で画像を表示する

```python
from IPython.display import Image, display

def display_image(image_path):
    """
    指定されたパスの画像を表示します。

    :param image_path: str
        画像ファイルのパス。
    """
    display(Image(filename=image_path, width=150))
```

## PILで画像をリサイズしコンパクトに表示する

```python
from PIL import Image
from IPython.display import display

def resize_image(image_path, new_width=None, new_height=None):
    """
    指定されたパスの画像を読み込み、新しい幅または高さにリサイズして表示します。
    縦横比は保持されます。

    :param image_path: str
        画像ファイルのパス。
    :param new_width: int, optional
        画像の新しい幅（ピクセル単位）。新しい高さが指定されていない場合に使用されます。
    :param new_height: int, optional
        画像の新しい高さ（ピクセル単位）。新しい幅が指定されていない場合に使用されます。

    例外:
        ValueError: 新しい幅と高さの両方がNoneの場合、または両方が指定されている場合に発生します。
    """
    # 画像を読み込む
    img = Image.open(image_path)

    # 元のサイズを取得
    original_width, original_height = img.size

    # 新しいサイズを計算
    if new_width is not None and new_height is None:
        # 新しい幅から高さを計算
        aspect_ratio = original_height / original_width
        new_height = int(new_width * aspect_ratio)
    elif new_height is not None and new_width is None:
        # 新しい高さから幅を計算
        aspect_ratio = original_width / original_height
        new_width = int(new_height * aspect_ratio)
    else:
        raise ValueError("新しい幅と新しい高さのどちらか一方のみを指定してください。")

    img_resized = img.resize((new_width, new_height))
    display(img_resized)

# 使用例
resize_image('path/to/your/image.png', new_width=150)
```
