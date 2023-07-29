---
layout: post
title: "opencvのテキスト書き込み"
date: 2023-07-29
excerpt: "opencvのテキストの書き込み方法"
kaggle: true
tag: ["opencv", "PIL", "cv2", "python"]
comments: false
sort_key: "2023-07-29"
update_dates: ["2023-07-29"]
---

# opencvのテキストの書き込み方法

## 概要
 - opencvのデフォルトの関数のput_textは日本語が入力できない
 - 一度、PILを利用して文字を書き込んでopencv形式に戻すなどもある

## cv2.put_text関数を使用する例

```python
def put_text(img, text='sample text'):
    # テキストの設定
    font = cv2.FONT_HERSHEY_SIMPLEX
    fontScale = 2
    color = (0, 0, 0)  # BGR format, here Red color
    thickness = 2
    # テキストを描画
    img = cv2.putText(img, text, (50, 50), font, fontScale, color, thickness, cv2.LINE_AA)
    return img
```

## PILのImageDraw.Draw.text関数を利用する例
 - 一度、`Image.fromarray関数`でPILの画像に変換する

```python
def put_text(img, text='サンプルテキスト', font_path='/usr/share/fonts/truetype/takao-gothic/TakaoGothic.ttf'):
    # OpenCVの画像をPILの画像に変換
    img_pil = Image.fromarray(cv2.cvtColor(img, cv2.COLOR_BGR2RGB))
    # フォントの設定
    font_size = 30
    font = ImageFont.truetype(font_path, font_size)
    # テキストを描画
    draw = ImageDraw.Draw(img_pil)
    draw.text((50, 50), text, font=font, fill=(0, 0, 0, 0))
    # PILの画像をOpenCVの画像に変換
    img = cv2.cvtColor(np.array(img_pil), cv2.COLOR_RGB2BGR)
    return img
```
