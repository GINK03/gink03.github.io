---
layout: post
title: "brave search"
date: 2026-01-18
excerpt: "Brave Search APIの使い方"
config: true
tag: ["brave search", "api", "python", "requests"]
comments: false
sort_key: "2026-01-18"
update_dates: ["2026-01-18"]
---

# brave search

## 概要
 - Brave Search APIでWeb検索結果を取得する
 - APIトークンは環境変数で渡す
 - requests_cacheを使うと繰り返し実行が速くなる

## 事前準備

環境変数にAPIトークンを設定する

```bash
export BRAVE_SEARCH_API="YOUR_TOKEN"
```

## 最小の実装

```python
import os
import requests


def search_brave(query: str, count: int = 10, country: str = "US"):
    endpoint = "https://api.search.brave.com/res/v1/web/search"

    headers = {
        "Accept": "application/json",
        "Accept-Encoding": "gzip",
        "X-Subscription-Token": os.environ.get("BRAVE_SEARCH_API"),
    }
    params = {
        "q": query,
        "count": count,
        "country": country,
        "search_lang": "jp",
    }

    response = requests.get(endpoint, headers=headers, params=params, timeout=10)
    response.raise_for_status()
    return response.json()
```

## キャッシュ付きの実装

```python
import os
import requests_cache


def search_brave_cached(query: str, count: int = 10, country: str = "US"):
    endpoint = "https://api.search.brave.com/res/v1/web/search"

    headers = {
        "Accept": "application/json",
        "Accept-Encoding": "gzip",
        "X-Subscription-Token": os.environ.get("BRAVE_SEARCH_API"),
    }
    params = {
        "q": query,
        "count": count,
        "country": country,
        "search_lang": "jp",
    }

    session = requests_cache.CachedSession(
        cache_name="data/http_cache_search_brave",
        backend="sqlite",
        expire_after=None,
        allowable_methods=("GET",),
    )
    response = session.get(endpoint, headers=headers, params=params, timeout=10)
    response.raise_for_status()
    return response.json()
```

## 取得結果の取り出し方

Web検索の結果は `web` -> `results` に入る

```python
result = search_brave_cached("NVDAの株価", count=5, country="JP")

for item in result.get("web", {}).get("results", []):
    title = item.get("title")
    url = item.get("url")
    age = item.get("age")
    print(title, url, age)
```

## パラメータのメモ

 - `count` は最大20
 - `country` はJPやUSなどの国コード
 - `search_lang` を `en` にすると英語の結果を優先できる
