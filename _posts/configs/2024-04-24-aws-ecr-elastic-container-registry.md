---
layout: post
title: "aws ecr"
date: 2024-04-24
excerpt: "aws ecrの使い方"
project: false
config: true
tag: ["aws", "ecr", "elastic container registry"]
comments: false
sort_key: "2024-04-24"
update_dates: ["2024-04-24"]
---

# aws ecrの使い方

## 概要
 - awsのコンテナレジストリ
 - GCPのContainer Registryと同じようなもの

## 基本的な使い方

### リポジトリの作成

```console
$ aws ecr create-repository --repository-name <your-image-repo>
```

### ログイン

```console
$ aws ecr get-login-password | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.<your-region>.amazonaws.com
```

### イメージのプッシュ

```console
$ docker tag <your-image> <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/<your-image-repo>:<tag>
$ docker push <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/<your-image-repo>:<tag>
```

### イメージの取得

```console
$ docker pull <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/<your-image-repo>:<tag>
```
