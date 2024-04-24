---
layout: post
title: "aws vpc"
date: 2024-04-24
excerpt: "aws vpcの概要と使い方"
project: false
config: true
tag: ["aws", "vpc", "virtual private cloud"]
comments: false
sort_key: "2024-04-24"
update_dates: ["2024-04-24"]
---

# aws vpcの概要と使い方

## 概要
 - aws vpcは、awsの仮想プライベートクラウドサービス
 - vpcはセキュリティグループ, サブネット、インターネットゲートウェイ、ルートテーブルなどのリソースから構成

## 基本的な使い方
 - `aws ec2 create-vpc --cidr-block 10.0.0.0/16` - vpcを作成
 - `aws ec2 describe-vpcs` - vpcの一覧を表示
 - `aws ec2 create-subnet --vpc-id vpc-abc12345 --cidr-block 10.0.1.0/24` - サブネットを作成 
 - `aws ec2 create-internet-gateway` - インターネットゲートウェイを作成
 - `aws ec2 attach-internet-gateway --vpc-id vpc-abc12345 --internet-gateway-id igw-abc12345` - インターネットゲートウェイをvpcにアタッチ
 - `aws ec2 create-internet-gateway` - ルートテーブルを作成
 - `aws ec2 create-route --route-table-id rtb-abc12345 --destination-cidr-block 0.0.0.0/0 --gateway-id igw-abc12345` - ルートテーブルにルートを追加
 - `aws ec2 create-security-group --group-name MySecurityGroup --description "My security group" --vpc-id vpc-abc12345` - セキュリティグループを作成

## セキュリティグループの操作
 - `aws ec2 describe-security-groups` - セキュリティグループの一覧を表示
 - `aws ec2 describe-security-groups --group-ids sg-12345678` - セキュリティグループの詳細を表示
 - `aws ec2 authorize-security-group-ingress --group-id sg-12345678 --protocol tcp --port 80 --cidr 0.0.0.0/0` - セキュリティグループのインバウンドルールを追加
 - `aws ec2 authorize-security-group-ingress --group-id sg-12345678 --protocol all --port all --cidr 0.0.0.0/0` - セキュリティグループのインバウンドルールを全て許可
