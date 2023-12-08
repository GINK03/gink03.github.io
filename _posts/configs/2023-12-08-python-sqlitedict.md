---
layout: post
title: "python sqlitedict"
date: 2023-12-08
excerpt: "pythonのsqlitedictの使い方"
config: true
tag: ["sqlitedict", "python", "cache"]
comments: false
sort_key: "2023-12-08"
update_dates: ["2023-12-08"]
---

# pythonのsqlitedictの使い方

## 概要
 - pythonでdictのような使い方ができるsqliteをバックエンドにしたデータ恒久化ライブラリ
 - APIからのデータ取得などで、データをキャッシュするのに便利

## インストール

```console
$ pip install sqlitedict
```

## 使い方

**openaiのembeddingを保存する例**

```python
import re
from dotenv import load_dotenv
from openai import OpenAI
from sqlitedict import SqliteDict

# .envから環境変数を読み込む
load_dotenv()
client = OpenAI()

# データベースを開く
db = SqliteDict("data/embedding_cache.sqlite")

def get_embedding(text, model="text-embedding-ada-002"):
    url_pattern = r"(http|ftp|https):\/\/([\w\-_]+(?:(?:\.[\w\-_]+)+))([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?"
    text = re.sub(url_pattern, "<URL>", text)
    if vec := db.get(text):
        return vec
    else:
        vec = client.embeddings.create(input = [text], model=model).data[0].embedding
        db[text] = vec
        db.commit()
        return vec
```
