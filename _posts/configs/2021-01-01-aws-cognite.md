---
layout: post
title: "aws cognite"
date: 2020-12-31
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
Username = "testuser1"

client.admin_create_user(UserPoolId=UserPoolId, \
                          Username=Username, \
                          UserAttributes=[{"Name":"address", "Value":"xxxx yyy zzz"}, \
                                         {"Name":"birthdate", "Value":"2020-11-03", \
                                            "Name": "email", "Value": "foo@bar.com"}])
```

*admin権限でユーザのパスワードをセット*
```python
client.admin_set_user_password(UserPoolId=UserPoolId,  \
                               Username=Username, \
                               Password="anyPassword0!", \
                               Permanent=True)
```

*admin権限でユーザをconfirm*
```python
client.admin_confirm_sign_up(UserPoolId=UserPoolId, \
                             Username=Username)
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
