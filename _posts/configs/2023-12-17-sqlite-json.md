---
layout: post
title: "sqlite json"
date: 2023-12-17
excerpt: "sqliteのjson拡張について"
project: false
config: true
tag: ["sqlite3", "db", "json", "json1"]
comments: false
sort_key: "2023-12-17"
update_dates: ["2020-12-17"]
---

# sqliteのjson拡張について

## 概要
 - sqliteはnosqlのようにjsonを扱える
 - jsonを扱うための拡張機能のことをjson1という

## 使用例

```sql
-- テーブル作成
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    data JSON
);
```

```sql
-- データ挿入
INSERT INTO users (data) VALUES ('{"name": "Alice", "age": 30}');
INSERT INTO users (data) VALUES ('{"name": "Bob", "age": 25}');
```

```sql
-- JSONデータの検索
SELECT * FROM users WHERE json_extract(data, '$.name') = 'Alice';
SELECT data FROM users WHERE JSON_EXTRACT(data, '$.age') > 28;
```

```sql
-- 特定のJSON要素の選択
SELECT json_extract(data, '$.name') AS name FROM users;
```

```sql
-- JSONデータの更新
UPDATE users SET data = json_set(data, '$.age', 31) WHERE json_extract(data, '$.name') = 'Alice';
```

```sql
-- JSONデータの削除
UPDATE users SET data = json_remove(data, '$.age') WHERE json_extract(data, '$.name') = 'Alice';
```

## 参考
 - [Storing and Querying JSON in SQLite: Examples and Best Practices](https://www.beekeeperstudio.io/blog/sqlite-json)
