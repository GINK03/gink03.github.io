---
layout: post
title: "requests cache"
date: 2026-01-18
excerpt: "requests_cacheでHTTPキャッシュを永続化する"
project: false
config: true
tag: ["python", "requests", "requests_cache"]
comments: false
sort_key: "2026-01-18"
update_dates: ["2026-01-18"]
---

# requests cache

## 概要
 - requests_cacheでHTTPレスポンスを永続化する
 - リダイレクトをキャッシュ対象に含めるとURL解決が速くなる
 - 既存のrequestsコードに近い形で導入できる

## 基本設定

```python
import requests_cache

session = requests_cache.CachedSession(
    "data/http_cache",
    backend="sqlite",
    expire_after=None,
)
```

## リダイレクトをキャッシュする

デフォルトでは200のみがキャッシュ対象になるため、3xxを明示的に含める

```python
session = requests_cache.CachedSession(
    "data/http_cache",
    backend="sqlite",
    expire_after=None,
    allowable_codes=(200, 301, 302, 303, 307, 308),
)

response = session.head(url, allow_redirects=True, timeout=5)
resolved_url = response.url
```

## 例 URL解決を関数化する

```python
import requests_cache

session = requests_cache.CachedSession(
    "data/http_cache",
    backend="sqlite",
    expire_after=None,
    allowable_codes=(200, 301, 302, 303, 307, 308),
)

def resolve_redirect_cached(url, target_domain="vertexaisearch.cloud.google.com"):
    if target_domain not in url:
        return url

    try:
        response = session.head(url, allow_redirects=True, timeout=5)
        return response.url
    except Exception:
        return url
```

## only_if_cachedの使い所

`only_if_cached=True` を指定するとキャッシュにない場合は通信せず504になる

 - 収集フェーズでは通常の通信でキャッシュを貯める
 - 解析フェーズでは `only_if_cached=True` で待ち時間を発生させない

```python
response = session.head(url, allow_redirects=True, timeout=5, only_if_cached=True)
from_cache = response.from_cache
```

## メモ

 - 404や500はデフォルトではキャッシュされない
 - `response.from_cache` でキャッシュ命中を確認できる
