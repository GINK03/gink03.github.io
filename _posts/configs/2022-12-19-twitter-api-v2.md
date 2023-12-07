---
layout: post
title: "twitter API v2"
date: 2022-12-19
excerpt: "twitter API v2の概要と使い方"
tags: ["api", "twitter api"]
config: true
comments: false
sort_key: "2022-12-19"
update_dates: ["2022-12-19"]
---

# twitter API v2の概要と使い方

## 概要
 - 2022年から新しく刷新されたtwitter API
 - 旧APIと認証方式が異なり`bear-token`から認証できる
   - twitter developerのappからtokenを発行できる

## ドキュメント
 - [https://developer.twitter.com/en/docs/twitter-api/](https://developer.twitter.com/en/docs/twitter-api/)

## データ構造の変化
 - `user`, `tweet`, `media`, `place`などの取得するための粒度があってそれを組み合わせて取得する
   - それぞれの粒度を設定するためにGET parameterに設定を行う

## 公式クエリ作成ツール
 - [https://developer.twitter.com/apitools/api](https://developer.twitter.com/apitools/api)
 - デバッグが難しいので公式ツールを使うのが堅実

## 公式のexample
 - [sampled-stream.py](https://github.com/twitterdev/Twitter-API-v2-sample-code/blob/main/Sampled-Stream/sampled-stream.py)
   - `requests`を`stream`モードで叩いている
   - [/tweepy/](/tweepy/)などのwrapperとなるソフトウェアを使うより確実

## recent searchでツイート取得する具体例

```python
import requests
import os
import json
import glob
import pandas as pd
bearer_token = os.environ.get("BEARER_TOKEN")
search_url = "https://api.twitter.com/2/tweets/search/recent"

# Optional params: start_time,end_time,since_id,until_id,max_results,next_token,
# expansions,tweet.fields,media.fields,poll.fields,place.fields,user.fields
def get_query_params(init=True, until_id=None):
    if init == True:
        query_params = {'query': '"keyword1" "keyword2" -is:retweet',
                        'tweet.fields': 'author_id,created_at,public_metrics',
                       'user.fields': 'id,name,username,created_at,description,public_metrics,verified',
                        "expansions": "author_id",
                       "start_time": "2023-12-01T21:00:00.00Z", # JST: 2023-12-01 12:00:00.00
                       "end_time": "2023-12-06T08:59:00.00Z", # JST: 2023-12-05 23:59:00.00
                       "max_results": "10"}
    else:
       query_params = {'query': '"keyword1" "keyword2" -is:retweet',
                'tweet.fields': 'author_id,created_at,public_metrics',
               'user.fields': 'id,name,username,created_at,description,public_metrics,verified',
                "expansions": "author_id",
                "until_id": until_id,
               "max_results": "100"}
    return query_params


def bearer_oauth(r):
    r.headers["Authorization"] = f"Bearer {bearer_token}"
    r.headers["User-Agent"] = "v2RecentSearchPython"
    return r


def connect_to_endpoint(url, params):
    response = requests.get(url, auth=bearer_oauth, params=params)
    print(response.status_code)
    if response.status_code != 200:
        raise Exception(response.status_code, response.text)
    return response.json()


def init():
    # イニシャル取得
    json_response = connect_to_endpoint(search_url, get_query_params(init=True,))
    ## 保存
    users = pd.DataFrame([x for x in json_response["includes"]["users"]])\
                .drop(columns=["public_metrics", "created_at"]) \
                .rename(columns={"id": "author_id"})
    data = pd.DataFrame(json_response["data"])
    df = pd.merge(users, data, on=["author_id"])
    save_title = f'{df["created_at"].min()}-{df["created_at"].max()}'
    df.to_pickle(f"data/{save_title}.pkl")


def repeat():
    # 継続取得
    ## 監視
    prev = pd.concat([pd.read_pickle(x).reset_index(drop=True) for x in glob.glob("data/*.pkl")])
    print("取得したサイズ", len(prev.drop_duplicates("id")), prev["created_at"].min(), prev["created_at"].max())

    prev = pd.concat([pd.read_pickle(x) for x in glob.glob("data/*.pkl")])
    min_id = prev["id"].min()

    ## 取得
    json_response = connect_to_endpoint(search_url, get_query_params(init=False, until_id=min_id))

    ## 保存
    users = pd.DataFrame([x for x in json_response["includes"]["users"]])\
                .drop(columns=["public_metrics", "created_at"]) \
                .rename(columns={"id": "author_id"})
    data = pd.DataFrame(json_response["data"])
    df = pd.merge(users, data, on=["author_id"])
    save_title = f'{df["created_at"].min()}-{df["created_at"].max()}'
    df.to_pickle(f"data/{save_title}.pkl")
```

## トラブルシューティング
 - `user.fields`が帰ってこない
   - 原因
     - `expansions`に`author_id`を指定していない 
   - 参考
     - [User.fields not working](https://twittercommunity.com/t/user-fields-not-working/151981)
