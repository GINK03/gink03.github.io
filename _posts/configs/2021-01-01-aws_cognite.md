---
layout: post
title:  "aws cognite"
date:   2020-12-31
excerpt: "aws cogniteの使い方"
project: false
config: true
tag: ["aws", "cognite"]
comments: false
sort_key: "2021-01-27"
update_dates: ["2021-01-27","2021-01-01","2021-01-01"]
---

# aws cogniteの使い方

## 概要
 - 認証関連のクライドサービス
   1. パスワード関連の管理
   2. 二段階認証の管理
   3. 自分の管理するコンピュータにパスワードを管理しなくていいので安全

## 構成・コンポーネントの説明

 - `ユーザプール`: ユーザの情報を記録しておく単位
 - `アプリクライアント`: ユーザプールにアクセスするためのクライアント
   - `クライアントID`: アプリクライアントのID
   - `シークレットの設定`: アプリクライアントの使用にシークレットを設定できるが、`boto3`でアクセスできなくなるため有効化しないほうが良い

## boto3による使用例
 
*clientの作成*  
```python
import boto3

client = boto3.client("cognito-idp", "us-west-2")
```

*userの作成*
```python
UserPoolId = "us-west-2_av3aGEPGK"
Username = "gimpei3"

client.admin_create_user(UserPoolId=UserPoolId, Username=Username, UserAttributes=[{"Name":"address", "Value":"栃木県日光市森友1123-2"}, {"Name":"birthdate", "Value":"2020-11-03", "Name": "email", "Value": "angeldust03@gmail.com"}])
```

*admin権限でユーザのパスワードをセット*  
```python
client.admin_set_user_password(UserPoolId=UserPoolId,  Username=Username, Password="anyPassword0!", Permanent=True)
```

*admin権限でユーザをconfirm*
```python
client.admin_confirm_sign_up(UserPoolId=UserPoolId, Username=Username)
```

*admin権限でユーザのパスワードを認証*
```python
resp = client.admin_initiate_auth(
        UserPoolId=UserPoolId,
        ClientId=ClientId,
        AuthFlow='ADMIN_NO_SRP_AUTH',
        AuthParameters={
            "USERNAME": Username,
            "PASSWORD": "cD3:oxf3",
        }
    )

print(resp)
```

認証に成功すると以下のような認証結果と設定したアトリビュートとsession情報が返ってくる
```json
{'ChallengeName': 'NEW_PASSWORD_REQUIRED', 'Session': 'AYABeM-mxdGxe9mSUsm1BdeR5CcAHQABAAdTZXJ2aWNlABBDb2duaXRvVXNlclBvb2xzAAEAB2F3cy1rbXMAS2Fybjphd3M6a21zOnVzLXdlc3QtMjowMTU3MzY3MjcxOTg6a2V5LzI5OTFhNGE5LTM5YTAtNDQ0Mi04MWU4LWRkYjY4NTllMTg2MQC4AQIBAHjnF-aQg6T9UqfEmc_QtN9hR8L_u8Pylt6mgE9ImGJtHAElMB4R8ERHtkKmScH1L8pOAAAAfjB8BgkqhkiG9w0BBwagbzBtAgEAMGgGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMLVjEC-boaztx6HzAAgEQgDsXw8BVjSNG1gSJIAEwPG7WNFnhBI7nhHJQA92MlcLEw6cVu7x_HMuewfeFukAQZbDjZI4s19CFITe2QQIAAAAADAAAEAAAAAAAAAAAAAAAAADkW6O-2gNtyiMAxGQmJFsE_____wAAAAEAAAAAAAAAAAAAAAEAAADLJ7XoH9vKBtpokTE9qw3Xz_wzsBBIqW7UQhAHCzGqgUg-aQ8bGh6658wkCgxzG_bDhPHRU-W5tQ5UmZlsvkZmIUBH1XIFnOoAIQJKXRyCIqF9QhLX87Vx-hqHcBbbxBz95XDchJd6iGlPvbuGulD2jascZj-L2XGwHRVLmUzIuUjPRmq7BFv7OebT1B1zBpkccPH7nrP_sm14reDBVs_kgZBrpP46ncoFywp6UuDP_Z38zPKIuwDlUYAPy6mMjQBudX0hb32thcOftsy2Wab0PY-DjxcEmFwShoWC', 'ChallengeParameters': {'USER_ID_FOR_SRP': 'gimpei3', 'requiredAttributes': '[]', 'userAttributes': '{"address":"栃木県日光市森友1123-2","email":"angeldust03@gmail.com"}'}, 'ResponseMetadata': {'RequestId': '52456b15-7954-4bd4-a42e-3a0cf8744654', 'HTTPStatusCode': 200, 'HTTPHeaders': {'date': 'Fri, 01 Jan 2021 08:56:36 GMT', 'content-type': 'application/x-amz-json-1.1', 'content-length': '1044', 'connection': 'keep-alive', 'x-amzn-requestid': '52456b15-7954-4bd4-a42e-3a0cf8744654'}, 'RetryAttempts': 0}}
```
