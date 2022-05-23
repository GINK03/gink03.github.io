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
   - ログデータは正規表現でパースできることを期待する
 - S3のデータのスキャン量に応じて課金される

## aws athena home
 - [home](https://ap-northeast-1.console.aws.amazon.com/athena/home)

## セットアップ
 1. aws athenaのホームにアクセスし、リージョンを指定のリージョンに合わせる
 2. `[設定]` -> `[管理]` -> `[設定を管理]`から結果の出力先のS3バケットを指定する
 3. `[エディタ]`から`データベース`を指定してクエリを編集して実行する
   - すでにデータベースが設定されていると仮定している

## big queryとの違い
 - S3からrow指向でデータを読み込むのでbig queryに比べてあんまり効率が良くない
 - プレビュー機能がない

## 新規でデータベースを追加する

### クエリエディタからデータベースを追加する

```sql
CREATE DATABASE mydatabase;
```

### テーブルを追加する

```sql
CREATE EXTERNAL TABLE IF NOT EXISTS cloudfront_logs (
  `Date` DATE,
  Time STRING,
  Location STRING,
  Bytes INT,
  RequestIP STRING,
  Method STRING,
  Host STRING,
  Uri STRING,
  Status INT,
  Referrer STRING,
  os STRING,
  Browser STRING,
  BrowserVersion STRING
  ) ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.RegexSerDe'
  WITH SERDEPROPERTIES (
  "input.regex" = "^(?!#)([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+([^ ]+)\\s+[^\(]+[\(]([^\;]+).*\%20([^\/]+)[\/](.*)$"
  ) LOCATION 's3://(s3のパス)/cloudfront/plaintext/';
```

## 参考
 - [Amazon Athenaによるデータ分析入門](https://business.ntt-east.co.jp/content/cloudsolution/column-72.html)


