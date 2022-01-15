---
layout: post
title: "wikipedia"
date: "2022-01-10"
excerpt: "wikipediaの(データの)使い方"
project: false
config: true
tag: ["wikipedia", "open data"]
comments: false
---

# wikipediaの(データの)使い方

## 概要
 - わかりやすいデータセットとしてwikipediaのダンプデータを使うことができる

## データの種類
 - `pages-meta-current.xml.bz2`
   - すべてのデータ
   - なにかを説明している百科事典の部分以外の編集者の自己紹介ページや会話なども含む

## ダウンロードサイト
 - [Index of /jawiki/](https://dumps.wikimedia.org/jawiki/)

## データの凡例

### pages-meta-current.xml.bz2
 - xmlで構成されている
 - `<page>`タグ以下の要素が1ページに該当する

```xml
<page>
  <title>title</title>
  <ns>0</ns>
  <id>integer</id>
  <revision>
    <id>integer</id>
    <parentid>integer</parentid>
    <timestamp>timestamp</timestamp>
    <contributor>
      <ip>ip-address</ip>
    </contributor>
    <comment>/* comment */</comment>
    <model>wikitext</model>
    <format>text/x-wiki</format>
    <text bytes="88508" xml:space="preserve">本文
      ...
```

## xmlの読み込み
 - 無圧縮で19GBあるのでインメモリで展開するのは非現実的である
 - `<page> ~ </page>`のテキストを取得して逐次lxmlなどで解析するなどする工夫が必要
   - 添付するコードの例では状態機械をqueueで作成して`<page>`タグ部分を抽出している

**具体的な例**  
```python
from collections import deque
import json
import itertools
from tqdm.auto import tqdm
from bs4 import BeautifulSoup
fp = open("./jawiki-latest-pages-meta-current.xml")

def parse_page(page):
    soup = BeautifulSoup(page, "lxml")
    title = soup.title.text
    text = soup.find("text").text

# <page>タグを見つける初期値
que = deque(list("<page>"))
que.popleft()

target_que = deque(list("<page>"))
for count in tqdm(itertools.count(0)):
    # 一文字追加
    que.append(fp.read(1))
    if que == target_que:
        buff = "<page>"
        while True:
            buff += fp.read(1)
            if "</page>" in buff[-7:]:
                break
        parse_page(buff)
    # 左を捨てる
    que.popleft()
```
