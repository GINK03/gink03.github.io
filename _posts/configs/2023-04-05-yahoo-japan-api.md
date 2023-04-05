---
layout: post
title: "yahoo japan api"
date: 2023-04-05
excerpt: "yahoo japan apiの使い方"
project: false
config: true
tag: ["api"]
comments: false
sort_key: "2023-04-05"
update_dates: ["2023-04-05"]
---

# yahoo japan apiの使い方

## 概要
 - Yahoo Japanが提供するAPI
 - よく使うところでは形態素解析のAPIなど

## セットアップ
 - [Yahoo!デベロッパーネットワーク](https://developer.yahoo.co.jp/)からログイン
 - [アプリケーションの管理](https://e.developer.yahoo.co.jp/dashboard/)でアプリケーションを作成する
   - `Client ID`が発行される(secret等はなく、Client IDだけで認証する仕様)

## 具体例

### 形態素解析

```python
import json
from urllib import request
import pprint

APPID = "<application-id>"  # <-- ここにあなたのアプリケーションIDを設定してください。
URL = "https://jlp.yahooapis.jp/MAService/V2/parse"


def post(query):
    headers = {
        "Content-Type": "application/json",
        "User-Agent": "Yahoo AppID: {}".format(APPID),
    }
    param_dic = {
      "id": "1234-1",
      "jsonrpc": "2.0",
      "method": "jlp.maservice.parse",
      "params": {
        "q": query
      }
    }
    params = json.dumps(param_dic).encode()
    req = request.Request(URL, params, headers)
    with request.urlopen(req) as res:
        body = res.read()
    return body.decode()

response = post("ずんだもんが生むんやで")
pp = pprint.PrettyPrinter(indent=2, width=120, depth=6)
pp.pprint(json.loads(response))
"""
{ 'id': '1234-1',
  'jsonrpc': '2.0',
  'result': { 'tokens': [ ['ず', 'ず', 'ず', '名詞', '普通名詞', '*', '*'],
                          ['んだ', 'んだ', 'んだ', '助動詞', '*', 'ナ形容詞', '基本形'],
                          ['もん', 'もん', 'もん', '名詞', '形式名詞', '*', '*'],
                          ['が', 'が', 'が', '助詞', '格助詞', '*', '*'],
                          ['生む', 'うむ', '生む', '動詞', '*', '子音動詞マ行', '基本形'],
                          ['ん', 'ん', 'ん', '名詞', '形式名詞', '*', '*'],
                          ['や', 'や', 'や', '助詞', '接続助詞', '*', '*'],
                          ['で', 'で', 'で', '助詞', '格助詞', '*', '*']]}}
"""
```

---

## 参考
 - [APIドキュメント](https://developer.yahoo.co.jp/sitemap/)
