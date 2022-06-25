---
layout: post
title: "litestream"
date: 2022-06-25
excerpt: "litestreamの概要と使い方"
tags: ["litestream", "sqlite", "s3"]
config: true
comments: false
sort_key: "2022-06-25"
update_dates: ["2022-06-25"]
---

# litestreamの概要と使い方

## 概要
 - [/sqlite/](/sqlite/)のデータをS3にstreamデータでレプリケーションするdaemon
 - 画期的な点として、cloudfloreのS3互換バケットなどがあれば、低遅延でユーザサイド（または、物理的にユーザの近くのサーバ）にDBを持たせることが可能になる
   - 中央集権型のデータベースの終焉の可能性

## インストール

```console
$ go install github.com/benbjohnson/litestream/cmd/litestream@latest
```

## 使用例

**minioでテストバケットを作成**
```console
$ minio server minio-test --address ":9000" --console-address ":9001"
$ mc alias set localhost http://localhost:9000 minioadmin minioadmin
$ mc mb localhost/test
```
 - [/minio/](/minio/)の詳しい使い方は専用のページを参照

**sqliteでテスト用のテーブルを作成**
```console
$ sqlite3 fruits.db
```

```sql
CREATE TABLE fruits (name TEXT, color TEXT);
INSERT INTO fruits (name, color) VALUES ('apple', 'red');
INSERT INTO fruits (name, color) VALUES ('banana', 'yellow');
```

**litestreamでバックアップ**
```console
$ export LITESTREAM_ACCESS_KEY_ID=minioadmin
$ export LITESTREAM_SECRET_ACCESS_KEY=minioadmin
$ litestream replicate fruits.db s3://test.localhost:9000/fruits.db
```
 - `test`にsqliteの内容がstreamで書き込まれていることを確認できる

**S3からDBのリストア**
```console
$ litestream restore -o fruits2.db s3://test.localhost:9000/fruits.db
```
 - `fruits2.db`という名前でS3から復元される

**リストアしたDBの内容の確認**
```console
$ sqlite3 fruits2.db 'SELECT * FROM fruits'
apple|red
banana|yellow
```

## 参考
 - [litestream.io/getting-started/](https://litestream.io/getting-started/)
 - [Litestream をさくらのオブジェクトストレージで試してみた](https://qiita.com/hnakamur/items/d07e47e6d063bcecf703)

