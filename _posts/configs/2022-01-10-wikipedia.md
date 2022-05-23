---
layout: post
title: "wikipedia"
date: "2022-01-10"
excerpt: "wikipediaの(データの)使い方"
project: false
config: true
tag: ["wikipedia", "open data"]
comments: false
sort_key: "2022-05-17"
update_dates: ["2022-05-17","2022-01-10"]
---

# wikipediaの(データの)使い方

## 概要
 - わかりやすいデータセットとしてwikipediaのダンプデータを使うことができる

## データの種類
 - `pages-meta-current.xml.bz2`
   - すべてのデータ
   - なにかを説明している百科事典の部分以外の編集者の自己紹介ページや会話なども含む
 - `jawiki-YYYYMMDD-pages-articles.xml`
   - 記事の全データ
   - 記事情報を参照したいときは、`pages-meta-current.xml.bz2`より軽いので便利
 - `jawiki-YYYYMMDD-pages-logging.xml`
   - wikipediaの記事の編集者に関するログ(アクセスして閲覧している人のログではない)
   - ユーザの追加、ブロック、記事の削除依頼などが主に見れるようである
 - `jawiki-YYYYMMDD-pages-meta-history6.xml-<value-start><value-end>`
   - wikipediaの記事の編集履歴のページ順のスナップショット
   - どの記事が頻繁に編集されるのか、どの記事がどのような編集履歴をたどったのかを明らかにすることができる
     - 編集が激しい記事 => 人気のミームだと考えられる

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
 - ライブラリを利用してパースするには[/python-xml/](/python-xml/)を参考

**具体的な例1**  
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
    char = fp.read(1)
    if len(char) == 0:
        break
    que.append(char)
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

**具体的な例2(iterparseを利用する例)**
```python
import xml.etree.ElementTree as ET
from bs4 import BeautifulSoup
import re
from tqdm.auto import tqdm
import itertools

# tree = ET.iterparse("jawiki-20220501-pages-articles.xml", events=("start", "end"))
tree = ET.iterparse("./sample.xml", events=("start", "end"))
counter = iter(tqdm(itertools.count(0)))

for (event, elem) in tree:
    # タグの粒度がpageのときにパースする
    if event == "end" and re.search("page$", elem.tag):
        next(counter)
        # pageの粒度でまるごとstring化して別のライブラリでパースする
        string = ET.tostring(elem, encoding='utf8').decode("utf8")
        # NOTE; string化したxmlはネームスペースが変化するので注意
        soup = BeautifulSoup(string, "lxml")
        # print(soup); soupをダンプすることでタグの内容を確認できる
        print(soup.find("ns0:title").text)
        print(soup.find("ns0:text").text)
```
