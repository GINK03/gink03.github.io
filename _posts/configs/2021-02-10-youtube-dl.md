---
layout: post
title: "youtube-dl"
date: 2021-02-10
excerpt: "youtube-dlの使い方"
tags: ["youtube", "python"]
config: true
comments: false
---

# youtube-dlの使い方

## インストール

```console
$ pip install youtube-dl
```

※ YouTubeの最新の構造に対応するために、最新のものを使ったほうが良い


## よく使うコマンド

**ダウンロード可能なフォーマット一覧**
```console
$ youtube-dl -F "${YOUTUBE_LINK}"
```

**フォーマットを指定してダウンロード**  
```console
$ youtube-dl -f ${FORMAT_NUM} "${YOUTUBE_LINK}"
```

**ベストフォーマットをダウンロード**
```console
$ youtube-dl -f best "${YOUTUBE_LINK}"
```

**名前をつけて保存**  
```console
$ youtube-dl -o ${OUTPUT_NAME} "${YOUTUBE_LINK}"
```

## proxyを指定してダウンロード

```console
$ youtube-dl --proxy http://{USERNAME}:{PASSWORD}@{HOST}:{PORT} "${YOUTUBE_LINK}"
```
