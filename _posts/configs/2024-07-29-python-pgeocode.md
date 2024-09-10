---
layout: post
title: "python pgeocode"
date: 2024-07-29
excerpt: "python pgeocodeの使い方"
tags: ["python", "pgeocode", "geocode"]
config: true
comments: false
sort_key: "2024-07-29"
update_dates: ["2024-07-29"]
---

# python pgeocodeの使い方

## 概要
 - pythonで郵便番号(zip code)から緯度経度を取得するためのライブラリ
 - 世界各国の郵便番号に対応している
 - `~/.cache/pgeocode` に国ごとのデータがキャッシュされる
   - そのままpandasで読み込むことができる

## latitudeとlongitudeの認識方法
 - latitudeは緯度で縦方向の位置を示す
   - 最大90度、最小-90度
 - longitudeは経度で横方向の位置を示す
   - 最大180度、最小-180度
   - 横の方のほうが大きい値を取るので`long`という名前が付いていると考えると認識しやすい

## インストール

**python**
```console
$ pip install pgeocode
```

## 使用例

```python
import pgeocode

nomi = pgeocode.Nominatim('jp')

# 郵便番号から各種情報を取得
series = nomi.query_postal_code("150-6139")
series
"""
|                | 0                                   |
|:---------------|:------------------------------------|
| postal_code    | 150-6139                            |
| country_code   | JP                                  |
| place_name     | Shibuya Shibuyasukuramburusukuea(39 |
| state_name     | Tokyo To                            |
| state_code     | 40                                  |
| county_name    | Shibuya Ku                          |
| county_code    | 1852582.0                           |
| community_name |                                     |
| community_code | nan                                 |
| latitude       | 35.664                              |
| longitude      | 139.6982                            |
| accuracy       | nan                                 |
"""
```
