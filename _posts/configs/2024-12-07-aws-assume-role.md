---
layout: post
title: "aws assume role"
date: 2024-12-07
excerpt: "aws assume roleの使い方"
config: true
tag: ["aws", "s3"]
sort_key: "2024-12-07"
update_dates: ["2024-12-07"]
comments: false
---

# aws assume roleの使い方

## 概要
 - 一時的な認証情報を払い出すための機能
   - e.g. webの面でのセキュリティ向上
 - ロールを作成し、そのロールを参照することで一時的な認証情報を取得する
   - `AccessKeyId`, `SecretAccessKey`, `SessionToken` が返される

## assume roleの参照例

**cli**
```bash
$ aws sts assume-role \
    --role-arn arn:aws:iam::*********:role/<role_name> \
    --role-session-name PollySession
```

**python**
```python
import boto3
from botocore.exceptions import ClientError

# AWS STSクライアントの初期化
sts_client = boto3.client('sts')
# 一時的なクレデンシャルを返す関数
def get_temporary_credentials(duration_seconds=3600):
    role_arn = "arn:aws:iam::*********:role/<role_name>"
    try:
        # AssumeRoleを使って一時的な認証情報を取得
        response = sts_client.assume_role(
            RoleArn=role_arn,
            RoleSessionName="PollySession",
            DurationSeconds=duration_seconds
        )
        # 認証情報を取得
        credentials = response['Credentials']
        return {
            'AccessKeyId': credentials['AccessKeyId'],
            'SecretAccessKey': credentials['SecretAccessKey'],
            'SessionToken': credentials['SessionToken'],
            'Expiration': credentials['Expiration'].isoformat()
        }
    except ClientError as e:
        return {'error': str(e)}
```

