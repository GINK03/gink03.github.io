---
layout: post
title: "aws cognito"
date: 2020-12-31
excerpt: "aws cognitoの使い方"
project: false
config: true
tag: ["aws", "cognito"]
comments: false
sort_key: "2021-01-27"
update_dates: ["2021-01-27","2021-01-01","2021-01-01"]
---

# aws cognitoの使い方

## 概要
 - 認証関連のクライドサービス
   1. パスワード関連の管理
   2. 二段階認証の管理
   3. 自分の管理するコンピュータにパスワードを管理しなくていいので安全
 - 一時的なクレデンシャルを発行することができる

## 構成・コンポーネントの説明

 - `ユーザプール`: ユーザの情報を記録しておく単位
 - `アプリクライアント`: ユーザプールにアクセスするためのクライアント
   - `クライアントID`: アプリクライアントのID
   - `シークレットの設定`: アプリクライアントの使用にシークレットを設定できるが、`boto3`でアクセスできなくなるため有効化しないほうが良い
 - `identity pool`: ユーザプールとアプリクライアントを紐づける

## 初期化

 - ユーザプールの作成
   - ユーザプールIDが返ってくる

```console
$ aws cognito-idp create-user-pool \
    --pool-name MyUserPool \
```

 - アプリクライアントの作成

```console
$ aws cognito-idp create-user-pool-client \
    --user-pool-id your-user-pool-id \
    --client-name MyAppClient \
    --generate-secret \
```

 - ユーザー認証フローを有効にする

```console
$ aws cognito-idp update-user-pool-client \
    --user-pool-id your-user-pool-id \
    --client-id your-client-id \
    --explicit-auth-flows ALLOW_USER_PASSWORD_AUTH,ALLOW_REFRESH_TOKEN_AUTH
```

 - Identity Poolの作成

```console
$ aws cognito-identity create-identity-pool \
    --identity-pool-name "MyIdentityPool" \
    --allow-unauthenticated-identities \
    --cognito-identity-providers ProviderName="cognito-idp.ap-northeast-1.amazonaws.com/your-user-pool-id",ClientId="your-client-id",ServerSideTokenCheck=true
```

 - Identity Poolとユーザプールを紐づける

```console
$ aws cognito-identity update-identity-pool \
    --identity-pool-id your-identity-pool-id \
    --identity-pool-name "YourIdentityPoolName" \
    --allow-unauthenticated-identities \
    --cognito-identity-providers ProviderName="cognito-idp.ap-northeast-1.amazonaws.com/your-user-pool-id",ClientId="your-client-id",ServerSideTokenCheck=true
```

 - Identity PoolにIAMロールを紐づける

```console
$ aws cognito-identity set-identity-pool-roles \
    --identity-pool-id your-identity-pool-id \
    --roles authenticated="arn:aws:iam::your-account-id:role/Cognito_MyIdentityPoolAuth_Role",unauthenticated="arn:aws:iam::your-account-id:role/Cognito_MyIdentityPoolUnauth_Role" \
```

## ユーザの管理

 - ユーザの作成

```console
$ aws cognito-idp admin-create-user \
    --user-pool-id your-user-pool-id \
    --username johndoe \
    --user-attributes Name=email,Value=johndoe@example.com 
```

 - パスワードを設定

```console
$ aws cognito-idp admin-set-user-password \
    --user-pool-id your-user-pool-id \
    --username johndoe \
    --password newPassword123# \
    --permanent
```
