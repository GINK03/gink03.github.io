---
layout: post
title: "python ppyx"
date: 2024-01-06
excerpt: "python pptxの使い方"
project: false
config: true
tag: ["python", "pptx", "powerpoint"]
comments: false
sort_key: "2024-01-06"
update_dates: ["2024-01-06"]
---

# python pptxの使い方

## 概要
 - pythonでpowerpointを操作するためのライブラリ
 - 読み書きが行える
 
## インストール

```console
$ pip install python-pptx
```

## 使い方

**powerpointの作成**
```python
from pptx import Presentation

# プレゼンテーションを作成
prs = Presentation()

# タイトルスライドのレイアウトを選択
slide_layout = prs.slide_layouts[0]

# スライドを追加
slide = prs.slides.add_slide(slide_layout)

# タイトルとサブタイトルを設定
title = slide.shapes.title
subtitle = slide.placeholders[1]

title.text = "Hello, World!"
subtitle.text = "python-pptx was here!"

# ファイルに保存
prs.save('test.pptx')
```

**powerpointの読込み**
```python
from pptx import Presentation

# 既存のファイルを開く
prs = Presentation('existing_presentation.pptx')

# スライドの数を取得して表示
print(f"Total number of slides: {len(prs.slides)}")

# 各スライドの内容を読み取る
for slide_number, slide in enumerate(prs.slides):
    print(f"\nSlide {slide_number + 1} contains:")
    for shape in slide.shapes:
        if hasattr(shape, "text"):
            print(shape.shape_type, shape.name, shape.text)
```

## 参考
 - [python-pptx](https://python-pptx.readthedocs.io/en/latest/)
