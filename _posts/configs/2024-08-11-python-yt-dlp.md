---
layout: post
title: "python yt-dlp"
date: 2024-08-11
excerpt: "python yt-dlpの使い方"
tags: ["python", "yt-dlp"]
config: true
comments: false
sort_key: "2024-08-11"
update_dates: ["2024-08-11"]
---

# python yt-dlpの使い方

## 概要
 - youtube-dlのフォーク
 - youtube-dlよりも高速で、多機能
   - 動画のダウンロード以外にもでYouTube上の検索結果を取得することも可能

## インストール

```console
$ pipx install yt-dlp
```

## ユースケース別使い方

### 特定のキーワードで検索

```python
import subprocess
import json
import pandas as pd

result = subprocess.run(['yt-dlp', f'ytsearch10:キーワード', '--print-json', '--skip-download'], 
                        capture_output=True, text=True)
data = [json.loads(line) for line in lines]
df = pd.DataFrame(data)
```

### トレンドの動画の情報を取得

```python
import subprocess
import json

channel_url = "https://www.youtube.com/feed/trending?gl=JP"
result = subprocess.run(['yt-dlp', '-J', '--flat-playlist', channel_url], 
                        capture_output=True, text=True)
data = json.loads(result.stdout)
```

### 音声のみをダウンロード

```console
$ yt-dlp -f bestaudio \
       -x --audio-format mp3 \
       --postprocessor-args "-ac 2 -ar 16000" \
       -o "%(title)s.%(ext)s" \
       "https://www.youtube.com/watch?v=<動画ID>"
```

### cookies.txtを使ってダウンロード
 - ブラウザ拡張Get cookies.txt LOCALLYなどで取得した`cookies.txt`を使うとログインが必要な動画もダウンロードできる
 - `cookies.txt`はyoutubeにログイン済みのブラウザプロファイルから保存する

```console
$ yt-dlp --cookies cookies.txt \
         -f bestvideo+bestaudio \
         -o "%(title)s.%(ext)s" \
         "https://www.youtube.com/watch?v=<動画ID>"
```

Pythonから`subprocess.run`で呼び出す場合の例

```python
import subprocess

url = "https://www.youtube.com/watch?v=<動画ID>"
subprocess.run(
    [
        "yt-dlp",
        "--cookies", "cookies.txt",
        "-f", "bestvideo+bestaudio",
        "-o", "%(title)s.%(ext)s",
        url,
    ],
    check=True,
)
```
