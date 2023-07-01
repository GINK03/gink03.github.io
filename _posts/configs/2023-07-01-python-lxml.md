---
layout: post
title: "python lxml"
date: "2023-07-01"
excerpt: "pythonのlxmlの使い方"
project: false
config: true
tag: ["python", "xml", "lxml"]
comments: false
sort_key: "2023-07-01"
update_dates: ["2023-07-01"]
---

# pythonのlxmlの使い方

## 概要
 - 基本的にpythonのデフォルトのライブラリの[/xml/](/python-xml/)と同じことができるが、速度が何十倍も早い
   - wikipediaのダンプファイルを解析するときなどは必須
 - 名前空間を省略できないので長い書き方になる
   - xmlの名前空間は`xmlns`で最初に定義されている

### 具体例

**以下のようなxmlを仮定**

```xml
<mediawiki xmlns="http://www.mediawiki.org/xml/export-0.10/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.mediawiki.org/xml/export-0.10/ http://www.mediawiki.org/xml/export-0.10.xsd" version="0.10" xml:lang="ja">
  <page>
    <title>あああ</title>
    <ns>0</ns>
    <text>text1</text>
    <datetime>YYYY-MM-DD</datetime>
  </page>
  <page>
    <title>いいい</title>
    <ns>0</ns>
    <text>text2</text>
    <datetime>YYYY-MM-DD</datetime>
  </page>
  <page>
    <title>ううう</title>
    <ns>0</ns>
    <text>text2</text>
    <datetime>YYYY-MM-DD</datetime>
  </page>
</mediawiki>
```

**datetimeをパースする例**
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

