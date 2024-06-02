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

## 使い方

 - データベースの作成

```python
import sqlite3

# データベースの作成
conn = sqlite3.connect('sample.db',
                       check_same_thread=False)
conn.execute('PRAGMA journal_mode=WAL;')
```

 - テーブルの作成


```python
c = conn.cursor()
c.execute('''
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        age INTEGER NOT NULL
    )
''')
conn.commit()
```

 - データの挿入

```python
c.execute('''
    INSERT INTO users (name, age) VALUES (?, ?)
''', ('Alice', 20))
conn.commit()
```

 - データの取得

```python
c.execute('''
    SELECT * FROM users
''')
c.fetchall()
```

 - データの更新

```python
c.execute('''
    UPDATE users SET age = ? WHERE name = ?
''', (21, 'Alice'))
conn.commit()
```

 - データの削除

```python
c.execute('''
    DELETE FROM users WHERE name = ?
''', ('Alice',))
conn.commit()
```

 - データベースのクローズ

```python
conn.close()
```
