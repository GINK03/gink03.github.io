---
layout: post
title: "aws s3 website hosting"
date: 2024-09-22
excerpt: "amazon s3でwebsiteのhostingの使い方"
config: true
tag: ["aws", "s3"]
sort_key: "2024-09-22"
update_dates: ["2024-09-22"]
comments: false
---

# AWS s3でwebsiteのhostingの使い方

## 概要
 - s3の設定を変更することで、s3でwebsiteをhostingすることができる
 - カスタムドメインも設定可能

## 手順
 1. s3 bucketを作成する
 2. パブリックアクセスブロックを無効化する
 3. bucketのポリシーを変更する
 4. index-documentとerror-documentを設定する
 5. コンテンツのアップロード

### パブリックアクセスブロックを無効化する

```console
$ aws s3api put-public-access-block \
	--bucket your-bucket-name \
	--public-access-block-configuration 'BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false'
```

### bucketのポリシーを変更する

**ポリシー**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::your-bucket-name/*"
    }
  ]
}
```

**ポリシーの設定**
```console
$ aws s3api put-bucket-policy \
	--bucket your-bucket-name \
    --policy file://policy-file-name.json
```

### index-documentとerror-documentを設定する

```console
$ aws s3 website s3://your-bucket-name/ --index-document index.html --error-document error.html
```

### コンテンツのアップロード

```console
# 適当なファイルを作成してアップロード
$ mkdir website
$ mv index.html website/ 
$ mv error.html website/
$ aws s3 sync ./website s3://your-bucket-name/

# 動作の確認
$ curl http://your-bucket-name.s3-website-<リージョン>.amazonaws.com
$ curl http://your-bucket-name.s3-website-<リージョン>.amazonaws.com/unknown-page
```
