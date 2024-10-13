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
 - `autocommit=True` にすると、データの変更が即座にデータベースに反映される
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
embedding_db = SqliteDict("embedding_db.sqlite")

def get_embedding(text, model="text-embedding-3-small"):
    url_pattern = r"(http|ftp|https):\/\/([\w\-_]+(?:(?:\.[\w\-_]+)+))([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?"
    text = re.sub(url_pattern, "<URL>", text)
    if vec := embedding_db.get(text):
        return vec
    else:
        vec = client.embeddings.create(input = [text], model=model).data[0].embedding
        embedding_db[text] = vec
        embedding_db.commit()
        return vec
```

**threadingを使って複数のリクエストを処理する例**

```python
from tqdm.auto import tqdm
import re
from sqlitedict import SqliteDict
from joblib import Parallel, delayed
from openai import OpenAI
import threading

client = OpenAI()
embedding_db = SqliteDict("embedding_db.sqlite", autocommit=True)
lock = threading.Lock()

def get_embedding(text, model="text-embedding-3-small"):
    url_pattern = r"(http|ftp|https):\/\/([\w\-_]+(?:(?:\.[\w\-_]+)+))([\w\-\.,@?^=%&:/~\+#]*[\w\-\@?^=%&/~\+#])?"
    text = re.sub(url_pattern, "<URL>", text)
    
    with lock:
        vec = embedding_db.get(text)
    if vec:
        return vec
    else:
        vec = client.embeddings.create(input=[text], model=model).data[0].embedding
        with lock:
            embedding_db[text] = vec
            # autocommit=Trueなので、明示的なcommitは不要
        return vec
```
