---
layout: post
title: "aws ecs"
date: 2020-12-21
excerpt: "aws ecsの使い方"
project: false
config: true
tag: ["ecs", "fargate", "aws"]
comments: false
sort_key: "2020-12-28"
update_dates: ["2020-12-28","2020-12-25","2020-12-25","2020-12-24"]
---

# aws ecs の使い方

## 概要
 - aws ecs はコンテナを実行するためのサービス
 - GCPのGKEやCloud Runに相当するサービス
 - ECS は EC2 と Fargate の2つのモードでコンテナを実行できる
   - EC2 モード: EC2 インスタンスを使ってコンテナを実行
   - Fargate モード: インフラストラクチャを気にせずコンテナを実行
 - 以下の要素で設定を管理
   - クラスタ: コンテナを実行するためのリソースの集合
   - タスク定義: コンテナの設定を記述
   - タスク: タスク定義を元に実行されるコンテナのインスタンス

## dockerのコンテナを実行する

### IAM ロールの作成
 - ECS タスクが AWS リソースにアクセスするために必要な IAM ロールを作成

```console
$ aws iam create-role --role-name ecsTaskExecutionRole --assume-role-policy-document file://ecs-task-execution-role.json
```

**ecs-task-execution-role.json**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

IAM ロールに必要なポリシーをアタッチ
```console
$ aws iam attach-role-policy --role-name ecsTaskExecutionRole --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy
```

### クラスタの作成
 - ECS クラスタを作成

```console
$ aws ecs create-cluster --cluster-name <your-cluster-name>
```

### タスク定義の登録
 - タスク定義を登録

```console
$ aws ecs register-task-definition --cli-input-json file://your-task-definition.json
```

**your-task-definition.json**
```json
{
  "family": "your-task-family",
  "executionRoleArn": "arn:aws:iam::your-account-id:role/ecsTaskExecutionRole",
  "networkMode": "awsvpc",
  "containerDefinitions": [
    {
      "name": "nginx-container",
      "image": "nginx:latest",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ],
  "requiresCompatibilities": ["FARGATE"],
  "cpu": "256",
  "memory": "512"
}
```

### サービスの作成

```console
$ aws ecs create-service \
    --cluster <your-cluster-name> \
    --service-name <your-service-name> \
    --task-definition <your-task-family> \
    --desired-count 1 \
    --launch-type FARGATE \
    --network-configuration "awsvpcConfiguration={subnets=[your-subnet-id],securityGroups=[your-security-group-id],assignPublicIp=ENABLED}"
```

### タスクリストの確認

```console
$ aws ecs list-tasks --cluster <your-cluster-name>
```
