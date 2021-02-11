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

## 公式ドキュメント等
 - [github.com](https://github.com/ytdl-org/youtube-dl)

## `youtube-dl`が著作権でteardownされたことについてのgithubの見解と対応
 - [Standing up for developers: youtube-dl is back](https://github.blog/2020-11-16-standing-up-for-developers-youtube-dl-is-back/)

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

## `view_count`, `like_count`等を取得する
ファイル名書き出しオプションにこれらを保存できるフィールドが存在する  

以下の例は`title`, `id`, `upload_date`, `view_count`, `like_count`, `dislike_count`, `duration`を保存する  

```console
$ youtube-dl -f best "${YOUTUBE_LINK}" -o "%(title)s_%(id)s_%(upload_date)s_%(view_count)s_%(like_count)s_%(dislike_count)s_%(duration)s.mp4"
```




