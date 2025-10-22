---
layout: post
title: "AWS Dynein"
date: 2025-10-22
excerpt: "AWS Dyneinの使用方法"
tag: ["aws", "dynein"]
config: true
comments: false
sort_key: "2025-10-22"
update_dates: ["2025-10-22"]
---

# AWS Dyneinの使用方法

## 概要
 - DyneinはAWS Labsが開発したDynamoDB用のCLIツール
 - DynamoDBのテーブルやデータ操作を簡単に行うことができる
 - Rustで書かれており、インストールにはRustのツールチェーンが必要
 - 環境変数は `AWS_PROFILE` と `AWS_REGION` を使用する
   - `AWS_DEFAULT_REGION` は参照しない

## インストール

```console
$ cargo install --git https://github.com/awslabs/dynein.git --locked
```

## 使い方

**テーブル一覧表示**

```console
$ dy ls
```

**テーブルのスキーマ表示**

```console
$ dy admin describe -t <table-name>
```

**テーブルのデータ表示**

```console
$ dy scan -t <table-name>
```

**特定のキーでアイテムを取得**

```console
$ dy get -t <table> <pk>
```


**テーブルデータのダンプ**

```console
$ dy export \
    --table <table-name> \
    --format jsonl \
    --output-file dump.jsonl
```

**テーブルデータのインポート**

```console
$ dy import \
    --table <table-name> \
    --format jsonl \
    --input-file dump.jsonl
```
