---
layout: post
title: "aws redshift serverless"
date: 2024-08-25
excerpt: "aws redshift serverlessの概要と使い方"
project: false
config: true
tag: ["aws", "redshift", "serverless"]
comments: false
sort_key: "2024-08-25"
update_dates: ["2024-08-25"]
---

# aws redshift serverlessの概要と使い方

## 概要
 - GCPのBigQueryのようなサーバーレスなデータウェアハウスサービス
 - RPU（Redshift Processing Unit）という単位で課金される
 - namespaceとworkgroupの概念がある
   - namespaceにIAMポリシーをアタッチする
 - BigQueryのようにWebUIからクエリを実行できたり、S3からデータを読み込んだりできる

## 初期設定

**namespaceの作成**
```console
$ aws redshift-serverless create-namespace \
    --namespace-name my-namespace-name \
    --db-name my-db-name
```

**workgroupの作成**
```console
$ aws redshift-serverless create-workgroup \
    --workgroup-name my-workgroup-name \
    --base-capacity 32 \
    --namespace-name my-namespace-name
```

**IAMロールの作成**
```console
$ aws iam create-role --role-name RedshiftS3AccessRole --assume-role-policy-document '{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "redshift.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}'
```

**S3への読み取りアクセスをロールに付与**
```console
$ aws iam attach-role-policy \
    --role-name RedshiftS3AccessRole \
    --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
```

**namespaceにIAMロールをアタッチ**
```console
$ aws redshift-serverless update-namespace \
    --iam-roles arn:aws:iam::********:role/RedshiftS3AccessRole \
    --namespace-name my-namespace-name
```

