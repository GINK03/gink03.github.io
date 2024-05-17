---
layout: post
title: "python mysql connector"
date: 2024-05-17
excerpt: "python mysql connectorの使い方"
project: false
config: true
tag: ["python", "mysql"]
comments: false
sort_key: "2024-05-17"
update_dates: ["2024-05-17"]
---

# python mysql connectorの使い方

## 概要
 - pure pythonでmysqlに接続するためのライブラリ
 - `ssl`を使って暗号化通信も可能なので、セキュリティを考慮したい場合にも使える

## インストール

```console
$ pip install mysql-connector-python
```

## 使い方

```python
import mysql.connector
import pandas as pd

# MySQLデータベースへの接続情報
username = 'username'
password = 'password'
host = '127.0.0.1'
port = "3306"
database = 'database'
ssl_ca_path = '/path/to/ca.pem'

# MySQLデータベースへの接続情報
config = {
    'user': username,
    'password': password,
    'host': host,
    'port': port,
    'database': database,
    'ssl_ca': ssl_ca_path,
}

# 接続
cnx = mysql.connector.connect(**config)
cursor = cnx.cursor()
# SQLクエリ
query = "SELECT * FROM keywords"
# SQLクエリを実行
cursor.execute(query)
# 結果をDataFrameに変換
df = pd.DataFrame(cursor.fetchall(), columns=[x[0] for x in cursor.description])
# コネクションをクローズ
cursor.close()
cnx.close()
```

## 参考
 - [MySQL Connector/Python](https://github.com/mysql/mysql-connector-python)
