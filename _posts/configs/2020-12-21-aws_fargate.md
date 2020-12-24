---
layout: post
title:  "fargate"
date:   2020-12-21
excerpt: "fargate"
project: false
config: true
tag: ["fargate", "aws"]
comments: false
---

# fargate

## 参考になるドキュメント
 - [ecs-cli compose create](https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/cmd-ecs-cli-compose-create.html)

## ecs-cli

**install**  
```console
$ wget https://amazon-ecs-cli.s3.amazonaws.com/ecs-cli-linux-amd64-latest
$ chmod +x ecs-cli-linux-amd64-latest
$ mv ecs-cli-linux-amd64-latest ~/.bin/ecs-cli
```

## Build a cluster

<details>
<summary>Build a cluster with CUI</summary>
<div markdown="1">
**1. naming a cluster and primitive settings**
```console
$ ecs-cli configure --cluster ${CLUSTER_NAME} --default-launch-type FARGATE --config-name ${CONFIG_NAME} --region us-west-2
```

**2. grant permission to access resources to tool**  
```console
$ ecs-cli configure profile --profile-name ${PROFILE_NAME} --access-key $AWS_ACCESS_KEY_ID --secret-key $AWS_SECRET_ACCESS_KEY
```

**3. up a cluster**  
```console
$ ecs-cli up --cluster-config ${CONFIG_NAME} --ecs-profile ${PROFILE_NAME}
```
このときに出力される`VPC_ID`と、`SUBNET_ID`は必要になる(後のロードバランサーやRDSとの接続にも必要だと思われる)

**4. open ports to security groups**  
ポート開放を行う 
```console
$ aws ec2 describe-security-groups --filters Name=vpc-id,Values=${VPC_ID} --region us-west-2
```
以上で、`SECURITY_GROUP_ID`がわかる  
```console
$ aws ec2 authorize-security-group-ingress --group-id ${SECURITY_GROUP_ID} --protocol tcp --port 80 --cidr 0.0.0.0/0 --region us-west-2
```
</div>
</details>

## Install containers to specified cluster
<details>
<summary>Install continers and lauch with CUI</summary>
<div markdown="1">
**1. edit compose yamls**
`docker-compose`のように、`docker-compose.yml`と`ecs-params.yml`を作成する必要がある  

*docker-compose.yml*
```yaml
version: '3'
services:
  web:
    image: tutum/hello-world
    ports:
      - "80:80"
```
*ecs-params.yml*
```yaml
version: 1
task_definition:
  task_execution_role: ecsTaskExecutionRole
  ecs_network_mode: awsvpc
  task_size:
    mem_limit: 0.5GB
    cpu_limit: 256
run_params:
  network_configuration:
    awsvpc_configuration:
      subnets:
        - "subnet-08532f9d9fd8de05d"
        - "subnet-00ecfeb1fcf3e906b"
      security_groups:
        - "sg-01ebe59998cad5405"
      assign_public_ip: ENABLED
```
通常、`subnets`と`security_groups`は再編集することがないので、ハードコードを期待してるものと考えられる

**2. compose**
```console
$ ecs-cli compose service up --create-log-groups
```
より簡単には
```console
$ ecs-cli compose service up
```

**3. options**  
*list*
```console
$ aws ec2 list-compose
```

*ps*  
```console
$ ecs-cli ps
```

*dockerのコンテナを作り直したときの反映等*  
```console
$ ecs-cli compose service stop # 一度止めて
$ ecs-cli compose service up # 再度, upすると新しいコンテンを参照して起動する
```

*`ecs-cli`のデフォルトのclusterを再設定する*
```console
$ ecs-cli configure --cluster test-cluster-01 --region us-west-2
```
</div>
</details>

## Launch service with load balancer
<details>
<summary>Laucn service with load balancer with WebUI</summary>
<div markdown="1">
`docker-compose.yml`に記されたサービス名・ポートが`--container-name`と`--container-port`に対応するようである.  
`--target-group-arn`は`load balancer`の`ターゲットグループ`から確認できる

```console
$ ecs-cli compose service up --cluster test-cluster-01 \
  --target-group-arn arn:aws:elasticloadbalancing:us-west-2:596985414779:targetgroup/test-lb-03/fadc4fb63351c278 \
  --container-name web \
  --container-port 80
```
</div>
</details>

<details>
<summary>Laucn service with load balancer with WebUI</summary>
<div markdown="1">
~NOTE: 現状、CUIで`load balancer`を有効化できていない~  
`load balancer`を有効化できた -> `arn`と`arnグループ`が異なっていたらしい

`load balancer`の設定
 1. `applicattion load balancer`である必要がある
 2. `vpc_id`と`security_group_id`は`cluster`と一致している必要がある
 3. `ターゲットの登録`は無視する

`load balancer`が作成できたら  
`Amazon ECS` -> `クラスター` -> `(すでにデプロイされたクラスターに)サービスを作成` -> `案内に従ってすすめる...`  
</div>
</details>

