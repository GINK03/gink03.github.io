---
layout: post
title: "localstack"
date: 2021-08-09
excerpt: "localstackの使い方"
config: true
tag: ["aws", "localstack"]
comments: false
sort_key: "2021-08-11"
update_dates: ["2021-08-11","2021-08-10"]
---

# localstackの使い方

## 概要
 - awsのローカルモック環境
 - s3, secrets-managerとかをローカルに再現することができる
 - dockerのプロセスを終了したらモック内のデータは消える

## インストールとセットアップ

```console
$ docker run -itd --rm -p 4566:4566 localstack/localstack:latest
```

エンドポイントが`http://localhost:4566`になる

## s3のバケットを作成する

```console
$ aws s3 mb s3://backet-name --endpoint-url=http://localhost:4566
```

## pandasでcsvをlocalstackのモックに書き込む

```python
import pandas as pd
from s3fs.core import S3FileSystem
import boto3

kwargs = {'endpoint_url':"http://localhost:4566",
          'region_name':'us-east-1'}

client = S3FileSystem(key="dummy",
                      secret="dummy",
                      use_ssl=True,
                      client_kwargs=kwargs)

df = pd.DataFrame({"a": [1,2,3,4]})
df.to_csv(client.open("backet-name/a.csv", mode='wb'))
```

## モックのsecrets managerを設定する
 - `--secret-string "file://PATH"`で内容を設定することができる

```console
aws --endpoint-url=http://localhost:4566 secretsmanager create-secret --name $AWS_SECRET_NAME --region $AWS_REGION_NAME --description "local" --secret-string "init"
aws --endpoint-url=http://localhost:4566 secretsmanager update-secret --secret-id $AWS_SECRET_NAME --region $AWS_REGION_NAME --description "local" --secret-string "file://~/.opt/secrets-manager.json"
aws --endpoint-url=http://localhost:4566 secretsmanager describe-secret --secret-id $AWS_SECRET_NAME --region $AWS_REGION_NAME
aws --endpoint-url=http://localhost:4566 secretsmanager get-secret-value --secret-id $AWS_SECRET_NAME --region $AWS_REGION_NAME
```
