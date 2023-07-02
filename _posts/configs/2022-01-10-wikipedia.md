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
 - `jawiki-YYYYMMDD-stub-meta-history.xml.gz`
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
 - ライブラリを利用してパースするには[/pythno-lxml/](/python-lxml/)や[/python-xml/](/python-xml/)を参考

**具体的な例(lxml)を利用**
```python
import pandas as pd
from tqdm.auto import tqdm
import itertools
import json
import lxml.etree
counter = iter(tqdm(itertools.count(0)))

dic = {}

# インクリメンタルなパース
context = lxml.etree.iterparse('./jawiki-20230620-stub-meta-history.xml', events=('end',), tag='{http://www.mediawiki.org/xml/export-0.10/}page')

# イベントと要素を反復処理
for event, elem in context:
    next(counter)
    # ここで各 <page> 要素を処理
    title = elem.find('{http://www.mediawiki.org/xml/export-0.10/}title')
    ts = [x.text for x in elem.findall('.//{http://www.mediawiki.org/xml/export-0.10/}datetime')]

    if title is not None:
        dic[title.text] = json.dumps(ts)

    # 現在の要素とその子要素をメモリから削除することが重要
    elem.clear()
    # さらにメモリ使用量を削減するために、間接参照を削除
    while elem.getprevious() is not None:
        del elem.getparent()[0]

df = pd.DataFrame.from_dict(dic, orient="index")
df.to_csv("title_ts.csv")
```

**具体的な例2(xml.etree.ElementTreeを利用する例)**
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
