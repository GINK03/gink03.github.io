---
layout: post
title: "python pyodbc"
date: 2024-05-17
excerpt: "python pyodbcの使い方"
project: false
config: true
tag: ["python", "pyodbc", "sql server"]
comments: false
sort_key: "2024-05-17"
update_dates: ["2024-05-17"]
---

# python pyodbcの使い方

## 概要
 - pythonでSQL Serverに接続するためのライブラリ

## インストール

```console
$ pip install pyodbc
```

## SQL Serverへの接続

```python
import pyodbc
import pandas as pd

# 接続パラメーターを設定
server = 'servername'
database = 'DBName'
username = 'username'
password = 'password'
driver= '{ODBC Driver 17 for SQL Server}'

# 接続文字列
conn_str = f'DRIVER={driver};SERVER={server};DATABASE={database};UID={username};PWD={password}'

# SQL Serverに接続
conn = pyodbc.connect(conn_str)

# SQLクエリ
query = "SELECT * FROM あなたのテーブル名"

# データフレームとしてクエリ結果を読み込み
df = pd.read_sql(query, conn)

# 接続を閉じる
conn.close()
```
