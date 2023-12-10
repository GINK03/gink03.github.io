---
layout: post
title: "python streamlit components"
date: 2023-12-10
excerpt: "streamlitのcomponentsの概要と使い方"
config: true
tag: ["streamlit", "python", "components"]
comments: false
sort_key: "2023-12-10"
update_dates: ["2023-12-10"]
---

# streamlitのdataframeの概要と使い方

## 概要
 - streamlitの表示オブジェクトはユーザ自身が作成することができる

## 使い方

### Xの投稿を表示する例

```python
import requests
import streamlit.components.v1 as components
from functools import lru_cache

@lru_cache(maxsize=128)
class Tweet(object):
    def __init__(self, url: str):
        # Use Twitter's oEmbed API
        # https://dev.twitter.com/web/embedded-tweets
        api = "https://publish.twitter.com/oembed?url={}".format(url)
        response = requests.get(api)
        self.text = response.json()["html"]

    def _repr_html_(self):
        return self.text

    def component(self):
        return components.html(self.text, height=600)

t = Tweet("https://twitter.com/OReillyMedia/status/901048172738482176").component()
```

## 参考
 - [Dispalying a tweet](https://discuss.streamlit.io/t/dispalying-a-tweet/16061)
