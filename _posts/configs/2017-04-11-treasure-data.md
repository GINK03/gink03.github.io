---
layout: post
title: "tresure data"
date: 2017-04-10
excerpt: "treasure dataの使い方"
tag: ["tresuredata"]
config: true
sort_key: "2018-01-19"
update_dates: ["2022-05-31", "2018-01-19"]
comments: false
---

# Tresure Dataの使い方

## 概要
 - データレークの一種
 - BigQueryを最近は使うことが多い

## ユースケース別使い方

### td commandのインストール

```console
$ curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-trusty-td-agent2.sh | sh
```

### td commandのユーザ認証

```console
$ td -e https://api.treasuredata.com account -f
```

### digdagのインストール

```console
$ sudo curl -o /usr/local/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest"
$ sudo chmod +x /usr/local/bin/digdag
```

### digdagの実行

```console
digdag run <dig-file>.dig
```

### digdagファイルのフォーマットの例

```yaml
timezone: UTC

_export:
  td:
    database: workflow_temp

+task1:
  td>: queries/<sql-file>.sql
  download_file: <output-filename>.csv
  engine: hive
```

### digdagがcallするsqlフォーマット

```sql
SELECT *
FROM <table-name>
```

---

## Treasure Dataの内容をダンプする

### 概要
 - tdコマンドを用いることでS3にダンプすることができる

### ダンプコマンド例

```console
$ td table:export {$DATABASE} {$TABLE} \
   --s3-bucket {$NAME} \
   --prefix {$FOLDER} \
   --aws-key-id {$AWS_KEY} \
   --aws-secret-key {$AWS_SECRET_KEY} \
   --file-format jsonl.gz
```
