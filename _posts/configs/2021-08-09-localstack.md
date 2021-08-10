---
layout: post
title: "localstack"
date: 2021-08-09
excerpt: "localstackの使い方"
config: true
tag: ["aws", "localstack"]
comments: false
---

# localstackの使い方

## 概要
 - awsのローカルモック環境
 - s3とかをローカルに再現することができる

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

