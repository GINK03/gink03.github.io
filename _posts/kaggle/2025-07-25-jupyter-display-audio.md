---
layout: post
title: "jupyter display audio"
date: 2025-07-25
excerpt: "jupyter display audio"
tag: ["jupyter", "kaggle", "python"]
comments: false
sort_key: "2025-07-25-jupyter-display-audio"
update_dates: ["2025-07-25"]
---

# jupyter display audio

## 標準機能で音声を再生する

```python
from IPython.display import Audio, display

def display_audio(audio_path):
    """
    指定されたパスの音声ファイルをJupyter Notebookで再生する関数
    """
    display(Audio(url=audio_path, embed=False)) # ノートブックに音声を埋め込む(ノートブックが軽くなる)
    display(Audio(filename=audio_path)) # ノートブックにbase64エンコードされた音声を埋め込む(ノートブックが重くなる)
```

