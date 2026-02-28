---
layout: post
title: "Python lxml"
date: 2023-07-01
excerpt: "Pythonのlxmlの使い方"
project: false
config: true
tag: ["python", "xml", "lxml"]
comments: false
sort_key: "2023-07-01"
update_dates: ["2023-07-01"]
---

# Pythonのlxmlの使い方

## 概要
 - Python標準ライブラリの `xml` と同様の処理ができ、速度面で有利なことが多い
   - Wikipediaのダンプファイルを解析するときなどに有用
 - 名前空間の指定が必要なので、XPathや `find` が長くなりやすい
   - XMLの名前空間は `xmlns` で定義されている
 - lxmlはスレッドセーフではないため、マルチスレッドで扱う場合は注意が必要

## 具体例

### インクリメンタルなパース

**以下のようなXMLを仮定**

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

### スレッドセーフ

```python
import threading
import time
from concurrent.futures import ThreadPoolExecutor, as_completed
from lxml import etree

# スレッド間で共有する単一のロックオブジェクトを定義
lxml_lock = threading.Lock()

def process_html_task(task_id: int, html_content: str) -> dict:
    """1件のタスクを処理するワーカー関数"""
    
    # 1. ロックが必要な処理（lxmlのパース等、クラッシュしやすい部分）
    # withブロックの中は同時に1つのスレッドしか実行できない（直列処理）
    with lxml_lock:
        parser = etree.HTMLParser()
        tree = etree.fromstring(html_content.encode('utf-8'), parser)
        # 必要なデータを抽出し、Pythonネイティブの文字列等に変換しておく
        extracted_text = "".join(tree.itertext()).strip()
        
    # 2. ロックが不要な処理（LLM API通信、ネットワークI/Oなど）
    # withブロックを抜けたので、ここは各スレッドが並列で実行する
    # ※ここではAPI通信の代わりにsleepでシミュレート
    time.sleep(1) 
    
    return {"task_id": task_id, "text": extracted_text}

def main():
    # テスト用のダミーデータ
    dummy_data = [
        (1, "<html><body><h1>テスト1</h1><p>本文1</p></body></html>"),
        (2, "<html><body><h1>テスト2</h1><p>本文2</p></body></html>"),
        (3, "<html><body><h1>テスト3</h1><p>本文3</p></body></html>"),
    ]
    
    results = []
    
    # ThreadPoolExecutorで並列実行
    with ThreadPoolExecutor(max_workers=3) as executor:
        # タスクの投入
        futures = {
            executor.submit(process_html_task, task_id, html): task_id 
            for task_id, html in dummy_data
        }
        
        # 完了したものから結果を取得
        for future in as_completed(futures):
            try:
                result = future.result()
                results.append(result)
                print(f"完了: タスク{result['task_id']}")
            except Exception as e:
                print(f"エラー発生: {e}")

    print("全ての処理が完了しました")

if __name__ == "__main__":
    main()
```
