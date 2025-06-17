---
layout: post
title: "jupyter display videos"
date: 2025-06-17
excerpt: "jupyter display videos"
tag: ["jupyter", "kaggle", "python"]
comments: false
sort_key: "2025-06-17"
update_dates: ["2025-06-17"]
---

# jupyter display videos

## 標準機能で画像を表示する

```python
from IPython.display import Video, display

def display_video(video_path):
    """
    指定されたパスの画像を表示します。
    """
    display(Video(video_path, embed=False, width=320)) # ノートブックに動画を表示する
    display(Video(video_path, embed=True, width=320)) # ノートブックにbase64エンコードされた動画を埋め込む(ノートブックが重くなる)
```

