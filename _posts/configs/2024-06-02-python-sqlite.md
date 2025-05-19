---
layout: post
title: "python sqlite"
date: 2024-06-02
excerpt: "python sqliteの使い方"
project: false
config: true
tag: ["python", "sqlite", "sqlite3"]
comments: false
sort_key: "2024-06-02"
update_dates: ["2024-06-02"]
---

# python sqliteの使い方

## 概要
 - デフォルトでsqlite3が使える
 - マルチプロセスでの利用時には`check_same_thread=False`を指定し、`PRAGMA journal_mode=WAL;`を実行

## 基本的な使い方

**データベースの作成とアクセス**

```python
import sqlite3

conn = sqlite3.connect("file:sample.db",
                       uri=True,
                       check_same_thread=False)
conn.execute('PRAGMA journal_mode=WAL;')
```

**読み取り専用の接続**

```python
conn = sqlite3.connect("file:sample.db?mode=ro",
                       uri=True,
                       check_same_thread=False)
```

**テーブルの作成**


```python
cur = conn.cursor()
cur.execute('''
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER NOT NULL
)
''')
conn.commit()
```

**データの挿入**

```python
cur = conn.cursor()
cur.execute('''
INSERT INTO users (name, age) VALUES (?, ?)
''', ('Alice', 20))
conn.commit()
```

**データの取得**

```python
cur.execute('''
SELECT
    *
FROM
    users
''')
cur.fetchall()
```

**データの更新**

```python
cur.execute('''
UPDATE
  users
SET
  age = ?
WHERE
  name = ?
''', (21, 'Alice'))
conn.commit()
```

**データの削除**

```python
cur.execute('''
DELETE FROM
  users
WHERE
  name = ?
''', ('Alice',))
conn.commit()
```

**データベースのクローズ**

```python
conn.close()
```

## pythonの関数をsqliteの関数として使う

```python
import sqlite3
import re

DB_PATH = 'sample.db'
conn = sqlite3.connect(f"file:{DB_PATH}?mode=ro", uri=True)

# REGEXP 用の関数を定義
def regexp(expr, item):
    try:
        if re.match(expr, str(item or "")):
            return 1
        else:
            return 0
    except Exception:
        return 0

# REGEXP 関数を登録
conn.create_function("REGEXP", 2, regexp)

# REGEXP を使ったクエリ
cur = conn.cursor()
sql = """
SELECT
    id,
    name,
    age
FROM
    users
WHERE
    name REGEXP '^John.*' -- 名前が'John'で始まる
"""

for (id, name, age) in cur.execute(sql):
    print(f"id: {id}, name: {name}, age: {age}")

cur.close()
conn.close()
```
