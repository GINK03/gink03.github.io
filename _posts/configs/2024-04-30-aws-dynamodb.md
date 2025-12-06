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

 - ProvisionedThroughputExceededException が起きる際
   - 原因
     - プロビジョンドスループットの不足によるスロットリング
     - 読み込みで発生する場合はRCUが不足しやすい 書き込みで発生する場合はWCUが不足しやすい
   - 対処
     - RCUやWCUを増やす
       - 例 読み込み負荷が高いならRCUを増やす 書き込み負荷が高いならWCUを増やす
       - CLI例
```console
$ aws dynamodb update-table \
    --table-name Items \
    --provisioned-throughput ReadCapacityUnits=10,WriteCapacityUnits=5
```
     - 請求モードをオンデマンドに変更する(PAY_PER_REQUEST)
       - スパイク耐性を高め運用を簡素化できる 料金は要求ベース
       - CLI例
```console
$ aws dynamodb update-table \
    --table-name Items \
    --billing-mode PAY_PER_REQUEST
```
   - 参考
     - [プロビジョンドモードのスロットリング](https://docs.aws.amazon.com/ja_jp/amazondynamodb/latest/developerguide/TroubleshootingThrottling-common-issues.html)
