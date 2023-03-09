---
layout: post
title: "youtube data api"
date: 2023-03-08
excerpt: "youtube data apiの使い方"
config: true
tag: ["gcp", "youtube api", "youtube data api"]
comments: false
sort_key: "2023-03-08"
update_dates: ["2023-03-08"]
---

# youtube data apiの使い方

## 概要
 - YouTubeで特定のチャンネルや動画のパフォーマンスを調べたり、キーワードで投稿された動画を検索したりするもの

## 必要なライブラリ

```console
$ python3 -m pip install --upgrade google-api-python-client
$ python3 -m pip install --upgrade google-auth-oauthlib google-auth-httplib2
```

## GCPからYouTube data APIの有効化とキーを払い出す
 - `APIとサービス`から`YouTube Data API`を検索して有効化
 - `OAuth 2.0 クライアント ID`からdesktop用の認証情報を作成し、jsonフォーマットでダウンロード
 - pythonなどで実行した際にローカルサーバでOAuth認証を通す

## 認証までの具体例

```python
import os
import google.oauth2.credentials
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
from google_auth_oauthlib.flow import InstalledAppFlow

# `OAuth 2.0 クライアント ID`のキーを `client_secret.json` で保存
CLIENT_SECRETS_FILE = "client_secret.json"
SCOPES = ['https://www.googleapis.com/auth/youtube.force-ssl']
API_SERVICE_NAME = 'youtube'
API_VERSION = 'v3'

def get_authenticated_service():
  flow = InstalledAppFlow.from_client_secrets_file(CLIENT_SECRETS_FILE, SCOPES)
  credentials = flow.run_local_server()
  return build(API_SERVICE_NAME, API_VERSION, credentials = credentials)

def channels_list_by_username(service, **kwargs):
  results = service.channels().list(
    **kwargs
  ).execute()
  
  print('This channel\'s ID is %s. Its title is %s, and it has %s views.' %
       (results['items'][0]['id'],
        results['items'][0]['snippet']['title'],
        results['items'][0]['statistics']['viewCount']))

os.environ['OAUTHLIB_INSECURE_TRANSPORT'] = '1'
service = get_authenticated_service()
channels_list_by_username(service, part='snippet,contentDetails,statistics', forUsername='GoogleDevelopers')
```

## video idを指定して詳細を調べる

```python
def get_video_details(youtube, **kwargs):
    return youtube.videos().list(
        part="snippet,contentDetails,statistics",
        **kwargs
    ).execute()

# idはURLのパラメータに記されている
get_video_details(service, id="xxxxxxx")
```

## キーワードで動画を検索
 - 投稿日時を指定できる
 - 時間で降順で表示できる
 - [その他指定できるパラメータ](https://developers.google.com/youtube/v3/docs/search/list?hl=ja)

```python
import pprint
pp = pprint.PrettyPrinter(indent=2, width=120, depth=6)

def search(youtube, **kwargs):
    return youtube.search().list(
        part="id,snippet",
        order="date",
        regionCode="jp",
        **kwargs
    ).execute()

# maxResultsは50が最大
response = search(service, q="なにかキーワード", maxResults=5, publishedAfter="2022-12-01T00:00:00Z", publishedBefore="2022-12-24T00:00:00Z")
items = response.get("items")
for item in items:
    pp.pprint(item)
    print("="*50)
```

---

## 参考
 - [Python クイックスタート/developers.google.com/youtube](https://developers.google.com/youtube/v3/quickstart/python?hl=ja)
 - [youtube/api-samples/github.com](https://github.com/youtube/api-samples/tree/master/python)
