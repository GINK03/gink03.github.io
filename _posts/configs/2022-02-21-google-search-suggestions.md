---
layout: post
title: "google search suggestions"
date: 2022-02-21
excerpt: "google search suggestionsの取得"
project: false
config: true
tag: ["google search suggestions", "google"]
comments: false
---

# google search suggestionsの取得

## 概要
 - google検索時に候補となるキーワードが表示されるサービスがある
   - APIで提供されており、このデータにアクセスすることができる

## 取得スクリプト(python)

```python
import string
import requests
from typing import List
import xml.etree.ElementTree as ET
import json
import time
from tqdm.auto import tqdm
import pandas as pd


def get_url(query: List[str]):
    base = "http://www.google.com/complete/search?hl=en&output=toolbar&q="
    return base + "+".join(query)


def fetch(suffix=None):
    query = ["ダイエット"]
    if suffix:
        query.append(suffix)
    url = get_url(query)
    with requests.get(url) as r:
        xml = r.text

    ret = []
    root = ET.fromstring(xml)
    for elm in root.iter("suggestion"):
        ret.append((suffix, elm.attrib["data"]))
    return ret


data = []
data += fetch()

jchars = [chr(code) for code in range(ord("あ"), ord("ん") + 1)]
for char in tqdm(list(string.ascii_lowercase) + jchars):
    data += fetch(suffix=char)
    time.sleep(2.0)


df = pd.DataFrame(data)
df.columns = ["suffix", "data"]
df.to_csv("output.csv", index=None)
```

## 結果

```csv
suffix,data
,ダイエット
,ダイエット食事
,ダイエットメニュー
,ダイエットサプリ
,ダイエットアプリ
,ダイエット運動
,ダイエットレシピ
,ダイエットスープ
,ダイエット速報
,ダイエットおやつ
a,ダイエット 朝ごはん
a,ダイエット アプリ
a,ダイエット 甘いもの
a,ダイエット 朝ごはん コンビニ
a,ダイエット アイス
a,ダイエット 飴
a,ダイエット アルコール
a,ダイエット 朝ごはん バナナ
a,ダイエット 歩く
a,ダイエット 朝ごはん 時短
b,ダイエット ビフォーアフター
b,ダイエット 便秘
b,ダイエット 弁当
b,ダイエット ブログ
b,ダイエット バナナ
b,ダイエット 病院
b,ダイエット ブロッコリー
b,ダイエット 晩御飯
b,ダイエット バレンタイン
b,ダイエット 豚肉
c,ダイエット 朝食
c,ダイエット チーズ
c,ダイエット チートデイ
c,ダイエット チョコ
c,ダイエット 昼食
c,ダイエット 注射
c,ダイエット 中学生
c,ダイエット 朝食 パンメニュー
c,ダイエット 茶碗蒸し
c,ダイエット チーズケーキ
d,ダイエット ダンス
d,ダイエット ドレッシング
d,ダイエット 作り置き
d,ダイエット 男性
d,ダイエット 断食
d,ダイエット ドリンク
d,ダイエット デザート
d,ダイエット 動画
d,ダイエット 大根
d,ダイエット デメリット
...
```


## 参考
 - [スプレッドシートで作る 簡易版キーワードサジェスト調査ツール](https://roi-log.com/2021/10/11/keyword-suggestion-on-spreadsheet/)
 - [Extract Google Suggestions API Data for SEO Insights with Python](https://importsem.com/query-google-suggestions-api-with-python/)
