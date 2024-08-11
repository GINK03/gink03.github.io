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

## 使い方

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
