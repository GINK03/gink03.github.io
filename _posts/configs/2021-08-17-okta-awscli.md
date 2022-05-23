---
layout: post
title: "okta-awscli"
date: 2021-08-17
excerpt: "okta-awscliの概要と使い方"
tags: ["aws", "okta"]
config: true
comments: false
sort_key: "2022-04-16"
update_dates: ["2022-04-16"]
---

# okta-awscliの概要と使い方

## 概要
 - awscliのためにクレデンシャルをその度発行するのは行けていないしセキュリティ的な懸念がある
   - okta認証を利用し、有効期限付きのクレデンシャルをその度発行してawscliを利用することでこの懸念を解消したもの

## okta-awscliのインストール

```console
$ python3 -m pip install okta-awscli
```

## okta-awscliの初期設定
 1. `~/.okta-awscli`のファイルを作成する
 2. `~/.aws/credentials`にrole_arnのみを記したプロファイルを作成する
   - 両方のファイル名のプロファイル名は同じだと望ましい

**`.okta-awscli`の具体例**  
```config
[profile_name]
base-url = <service-name>.okta.com
username = <username>
password = <password>
app-link = https://<service-name>.okta.com/home/amazon_aws/********************
duration = 3600
role = arn:aws:iam::*******:role/************-aws_poweruseraccess
```

**`~/.aws/credentials`の具体例**  
```config
[profile_name]
role_arn = arn:aws:iam::**********:role/Step-poweruseraccess
source_profile = step
```

## okta経由でプロファイルに紐づくクレデンシャルを取得

**oktaのワンタイムキーでクレデンシャルを発行する**  

```console
$ okta-awscli --okta-profile <profile_name> --profile <profile_name>
```

**設定したプロファイルを確認**  
```console
$ aws sts get-caller-identity --profile <profile_name>
{
    "UserId": "***********",
    "Account": "***********",
    "Arn": "***********"
}
```

## 実際に使うときにデフォルトのプロファイルを設定する
 - 環境変数を設定する

```console
$ export AWS_DEFAULT_PROFILE=<profile_name>
```

## 参考
 - [okta-awscli/GitHub](https://github.com/okta-awscli/okta-awscli)
