---
layout: post
title: "terraform"
date: 2022-02-18
excerpt: "terraformの基本的な使い方"
project: false
config: true
tag: ["terraform", "gcp"]
comments: false
---

# terraformの基本的な使い方

## 概要
 - Terraform is an open-source infrastructure as code software tool

## インストール

**ubuntu, debian**  
```console
$ curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
$ sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
$ sudo apt-get update && sudo apt-get install terraform
```

## ローカルでdockerコンテナを立ち上げる

 1. ディレクトリを作成し、`main.tf`というファイルを作成する

```tf
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 2.15.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name = "tutorial"
  ports {
    internal = 80
    external = 8080
  }
}
```

 2. 初期化を行う

```console
$ terraform init
```

 3. 反映する
```console
$ terraform apply
```
 4. 動作確認

```console
$ curl http://localhost:8080
<!DOCTYPE html>
<html>
...
```

## 参考
 - [AWS入門 - Terraform 使ってみる](https://zenn.dev/umatoma/articles/9fb6e2b8481838)

