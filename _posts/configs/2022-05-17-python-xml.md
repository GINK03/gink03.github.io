---
layout: post
title: "pythonでのxml"
date: "2022-05-17"
excerpt: "pythonでのxmlの扱い方"
project: false
config: true
tag: ["python", "xml"]
comments: false
sort_key: "2022-05-17"
update_dates: ["2022-05-17"]
---

# pythonでのxmlの扱い方

## 概要
 - 小さいxmlデータであれば、`BeautifulSoup`などで簡単にパースできる
 - wikipediaなどxmlでダンプされた巨大なデータがあり、パースには独自のノウハウが要求される
 - 大量のデータを処理する際には`lxml`だけで処理を行うほうがだいぶ高速

## `xml.etree.ElementTree`で`iterparse`する
 - 概要と留意点
   - `iterparse`は巨大なxmlデータでもインメモリで扱わないことでパース可能にする関数である
   - `event`(tagの特定の状態)の始まりと終わりの段階でトラップできる
     - トラップを完了した内容をパース可能
     - `"end"`をトラップするのが良さそう
   - トラップを完了した粒度をstring型に変換し、他の(BeautifulSoupなどの)xmlパーサーに渡して処理するとiteratorのカーソルを弄らないので安全
   - tostring関数はデフォルトではus-asciiのbytes型を返すので、utf8に変更して、bytesをutf8にデコードする必要がある

### 具体例

以下のようなxmlを仮定する

```xml
<mediawiki xmlns="http://www.mediawiki.org/xml/export-0.10/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.mediawiki.org/xml/export-0.10/ http://www.mediawiki.org/xml/export-0.10.xsd" version="0.10" xml:lang="ja">
  <page>
    <title>あああ</title>
    <ns>0</ns>
    <text>text1</text>
  </page>
  <page>
    <title>いいい</title>
    <ns>0</ns>
    <text>text2</text>
  </page>
  <page>
    <title>ううう</title>
    <ns>0</ns>
    <text>text2</text>
  </page>
</mediawiki>
```

これをパースするには以下のようなコードでできる
```python
import xml.etree.ElementTree as ET
from bs4 import BeautifulSoup
import re
from tqdm.auto import tqdm
import itertools

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

## 参考
 - [xml.etree.ElementTree --- ElementTree XML API/Python Docs](https://docs.python.org/ja/3/library/xml.etree.elementtree.html#xml.etree.ElementTree.TreeBuilder)

