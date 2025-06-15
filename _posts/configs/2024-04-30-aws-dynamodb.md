---
layout: post
title: "aws dynamodb"
date: 2024-04-30
excerpt: "aws dynamodbの概要と使い方"
project: false
config: true
tag: ["aws", "aws dynamodb", "dynamodb"]
comments: false
sort_key: "2024-04-30"
update_dates: ["2024-04-30"]
---

# aws dynamodbの概要と使い方

## 概要
 - AWSのマネージドNoSQLデータベースサービス
 - GCPのFirestoreに相当
 - pythonでの操作はboto3を使う

## CLI

**テーブル一覧の取得**
```console
$ aws dynamodb list-tables
```

**テーブルの作成**
```console
$ aws dynamodb create-table \
    --table-name Items \
    --attribute-definitions \
        AttributeName=item_id,AttributeType=S \
    --key-schema \
        AttributeName=item_id,KeyType=HASH \
    --provisioned-throughput \
        ReadCapacityUnits=1,WriteCapacityUnits=1
```

**テーブルの削除**
```console
$ aws dynamodb delete-table --table-name Items
```

**データを追加**
```console
$ aws dynamodb put-item \
    --table-name Items \
    --item \
        '{"item_id": {"S": "1"}, "name": {"S": "apple"}}'
```

**データを取得**
```console
$ aws dynamodb get-item \
    --table-name Items \
    --key \
        '{"item_id": {"S": "1"}}'
```

### トラブルシューティング

 - dynamodbをバックエンドにしたAPIで起動時にエラーが起きる
   - 原因
     - WCU（書き込みキャパシティユニット）が不足している
   - 対処
     - テーブルのWCUを増やす
   - 参考
     - [プロビジョンドモードのスロットリング](https://docs.aws.amazon.com/ja_jp/amazondynamodb/latest/developerguide/TroubleshootingThrottling-common-issues.html)
