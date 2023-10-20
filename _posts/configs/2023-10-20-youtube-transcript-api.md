---
layout: post
title: "youtube-transcript-api"
date: 2023-10-20
excerpt: "youtube-transcript-apiの使い方と概要"
config: true
tag: ["youtube", "python", "api"]
comments: false
sort_key: "2023-10-20"
update_dates: ["2023-10-20"]
---

# youtube-transcript-apiの使い方と概要

## 概要
 - youtubeの字幕を取得するためのライブラリ
 - 非公式のAPIを使用しているため、youtubeの仕様変更により動作しなくなる可能性がある

## インストール

```console
$ pip install youtube-transcript-api
```

## 使い方

```python
from youtube_transcript_api import YouTubeTranscriptApi
import pandas as pd

# 動画IDを指定して字幕を取得
df = pd.DataFrame(YouTubeTranscriptApi.get_transcript("動画ID", languages=['ja']))
display(df) # 出力カラムはtext, start, duration
```

## 参考
 - [jdepoix/youtube-transcript-api](https://github.com/jdepoix/youtube-transcript-api)
