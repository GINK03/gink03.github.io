---
layout: post
title: "google custom search engine" 
date: "2023-07-05"
excerpt: "google custom search engineの概要と使い方"
config: true
tag: ["google custome search engine", "custom search api"]
comments: false
sort_key: "2023-07-05"
update_dates: ["2023-07-05"]
---

# google custom search engineの概要と使い方

## 概要
 - googleのサーチエンジンをAPIとして利用できる機能
 - 一日100件までは無料で利用できるがそれ以上は有料
   - $5/1000件
 - 有料プランで使うにはGCPプロジェクトが必要

## custom search apiの利用開始方法
 - 必要なもの
   - `Search engine ID`と`API キー`があれば利用できる
 - 手順
   - [Programmable Search Engine](https://programmablesearchengine.google.com/controlpanel/all)から必要な検索エンジンの条件を定義し作成
     - 作成すると`Search engine ID`が発行される
   - GCPで`APIとサービス`で`Custom Search API`を有効化する
   - [プログラム可能検索要素 Paid API](https://developers.google.com/custom-search/docs/paid_element?hl=ja)から`APIのキー`を発行する

## pythonからの利用例

```python
import os
import requests
import pandas as pd

def search(query: str) -> pd.DataFrame:
    tmp = []
    api_key = os.environ.get("GOOGLE_CUSTOM_SEARCH_API_KEY")
    if not api_key:
        raise ValueError("GOOGLE_CUSTOM_SEARCH_API_KEY is required")
    cse_id = "bdec2f8ae667e39e1" # custom search engine id
    url = f"https://www.googleapis.com/customsearch/v1?q={query}&key={api_key}&cx={cse_id}"    
    response = requests.get(url)
    if response.status_code == 200:
        results = response.json()
        items = results.get("items")
        if not items:
            print("No results")
            return pd.DataFrame(columns=["title", "snippet", "link"])
        for result in items:
            tmp.append(result)
    else:
        print("Error", response.status_code)
    return pd.DataFrame(tmp)[["title", "snippet", "link"]]

display(search("たぬかな"))
"""
| title                             | snippet                           | link                              |
|:----------------------------------|:----------------------------------|:----------------------------------|
| たぬかな (@kana_xia...            | たぬかな. @kana_xia...            | https://twitter.com/kana_xiao...  |
| たぬかな_ - Twitch...             | たぬかな 無職. ... Pr...          | https://www.twitch.tv/tanukana... |
| たぬかな - Wikipedi...            | たぬかな（1992年〈平成4年...      | https://ja.wikipedia.org/wiki/... |
| たぬかな | 格ゲープレイヤー...    | たぬかな ... 元プロ格闘ゲ...      | http://fgamers.saikyou.biz/?%E... |
| ｢170以下は人権ない｣で大炎...      | たぬかなさんは、日本で2人目の...  | https://toyokeizai.net/article... |
| スナックたぬかな【まとめ&切り...  | たぬかなさんの配信をラジオ感覚... | https://www.youtube.com/@snack... |
| “お騒がせ美人ゲーマー”たぬか...   | 配信での不適切な発言で所属チー... | https://news.yahoo.co.jp/artic... |
| たぬかな | 人物一覧 | 集...       | たぬかなに関する記事の一覧です... | https://shueisha.online/person... |
| 「人権ない」炎上の美女ゲーマー... | Jun 5, 2023 ......                | https://news.yahoo.co.jp/artic... |
| 炎上美女ゲーマー・たぬかな 「...  | Jun 12, 2023 .....                | https://yorozoonews.jp/article... |
"""
```

## 参考
 - [Custom Search JSON API: はじめに/developers.google.com](https://developers.google.com/custom-search/v1/introduction?hl=ja)
