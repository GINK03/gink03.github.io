---
layout: post
title: "youtube-dl"
date: 2021-02-10
excerpt: "youtube-dlの使い方"
tags: ["youtube", "python", "youtube-dl", "yt-dlp"]
config: true
comments: false
sort_key: "2022-05-12"
update_dates: ["2022-05-12","2022-04-25","2021-09-08","2021-08-16","2021-02-11","2021-02-10"]
---

# youtube-dlの使い方

## 概要
 - youtubeやpornhubや対応するサイトから動画をダウンロードできるツール
 - GitHubでホストされおり、GitHubの理念により、著作権関連でteardownされることはない
   - 参考
	 - [Standing up for developers: youtube-dl is back](https://github.blog/2020-11-16-standing-up-for-developers-youtube-dl-is-back/)  
 - ffmpegがインストールされていないと、音声と動画を分離している際に合成できない
 - 開発がゆっくりなこともあり、活発なforkとして`yt-dlp`がある

## 公式ドキュメント等
 - [youtube-dl/github.com](https://github.com/ytdl-org/youtube-dl)
 - [yt-dlp/github.com](https://github.com/yt-dlp/yt-dlp)

## インストール

```console
$ python3 -m pip install youtube-dl -U
$ python3 -m pip install yt-dlp -U
```

※ YouTubeの最新の構造に対応するために、最新のものを使ったほうが良い


## よく使うコマンドとオプション

**ダウンロード可能なフォーマット一覧**
```console
$ youtube-dl -F "${YOUTUBE_LINK}"
```
 - 番号とその品質の詳細が記さた出力が得られる

**フォーマットを指定してダウンロード**  
```console
$ youtube-dl -f ${FORMAT_NUM} "${YOUTUBE_LINK}"
```
 - 超高画質の動画は音声と動画のフォーマットが別々になる
 
**動画と音声のフォーマットをそれぞれ指定してダウンロードしてマージ**  

```console
$ youtube-dl -f ${FORMAT_NUM1}+${FORMAT_NUM2} --merge-output-format mp4 "${YOUTUBE_LINK}"
```
 - マージ機能を利用するにはffmpegがインストールされている必要がある
 - webm形式の4kの動画番号を指定し、webm形式の音声番号を指定し、合成することで任意の品質の動画にできる

**ベストフォーマットをダウンロード**
```console
$ youtube-dl -f best "${YOUTUBE_LINK}"
```

**名前をつけて保存**  
```console
$ youtube-dl -o ${OUTPUT_NAME} "${YOUTUBE_LINK}"
```

**チャンネルの動画をすべてダウンロードする**  
```console
$ youtube-dl -f best -ciw -o "%(title)s.%(ext)s" -v https://www.youtube.com/channel/${CHANNEL_ID}
```

**エラーが発生しても継続する**
 - 特に`yt-dlp`でyoutube以外の動画をダウンロードする際に発生しがちで`-i`オプションを指定しないと、リトライを繰り返してしまう

```console
$ yt-dlp <movie-list> -i
```

## youtube-dlのforkのyt-dlpについて
 - 概要
   - youtube-dlを並列ダウンロード可能にしたもの
   - コマンドや引数がほとんど同じなので、youtube-dlを使うようにして、yt-dlpを使うことができる

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




