---
layout: post
title: "aws athena"
date: 2022-02-01
excerpt: "aws athenaの使い方"
project: false
config: true
tag: ["olap", "aws", "aws athena", "athena"]
comments: false
sort_key: "2022-02-01"
update_dates: ["2022-02-01"]
---

# aws athenaの使い方

## 概要
 - AWSが提供するサーバレスのOLAP Database
 - S3にログデータが置いてあることを期待する
   - ログデータはcsv形式や正規表現でパースできることを期待している
 - S3のデータのスキャン量に応じて課金される

## aws athena home
 - [home](https://ap-northeast-1.console.aws.amazon.com/athena/home)

## セットアップ
 1. aws athenaのホームにアクセスし、リージョンを指定のリージョンに合わせる
 2. `[設定]` -> `[管理]` -> `[設定を管理]`から結果の出力先のS3バケットを指定する
 3. `[エディタ]`から`データベース`を指定してクエリを編集して実行する
   - すでにデータベースが設定されていると仮定している

## redshift/bigqueryとの違い
 - S3からrow指向でデータを読み込むのでbigqueryに比べてあんまり効率が良くない
 - プレビュー機能がない
 - S3にデータが置いてあることを前提にしおり、出力もS3に保存される

## 新規でデータベースを追加する

**クエリエディタからデータベースを追加する**
```sql
CREATE DATABASE my-database;
```

## テーブルを作成

**apachelog内のjsonデータをパースする**
```sql
CREATE EXTERNAL TABLE IF NOT EXISTS apache_logs_json (
    json_data string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
WITH SERDEPROPERTIES (
    "input.regex" = ".*(\\{.*\\})"
)
LOCATION 's3://my-bucket/apache_logs_json/'
TBLPROPERTIES ('has_encrypted_data'='false');
```

**jsonデータをパースしてテーブルを作成する**
```sql
CREATE EXTERNAL TABLE IF NOT EXISTS log_table (
    time timestamp,
    user string,
    host string,
    event string,
    req string,
    referrer string,
    ua string
)
LOCATION 's3://my-bucket/log_table/'
TBLPROPERTIES ('has_encrypted_data'='false');
```

```sql
INSERT INTO log_table

SELECT 
    from_iso8601_timestamp(json_extract_scalar(json_data, '$.time')) as time,
    json_extract_scalar(json_data, '$.user') as user,
    json_extract_scalar(json_data, '$.host') as host,
    json_extract_scalar(json_data, '$.event') as event,
    json_extract_scalar(json_data, '$.req') as req,
    json_extract_scalar(json_data, '$.referrer') as referrer,
    json_extract_scalar(json_data, '$.ua') as ua
FROM 
    "my-database"."apache_logs_json" 
```
