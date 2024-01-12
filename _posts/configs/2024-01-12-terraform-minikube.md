---
layout: post
title: "terraform + minikube"
date: 2024-01-12
excerpt: "terraform + minikubeの基本的な使い方"
project: false
config: true
tag: ["terraform", "minikube", "kubernetes"]
comments: false
sort_key: "2024-01-12"
update_dates: ["2024-01-12"]
---

# terraform + minikubeの基本的な使い方

## 概要
 - terraformでminikube上にnginxをデプロイする

## インストール

**nix**  
```console
$ nix-env -iA nixpkgs.terraform
$ nix-env -iA nixpkgs.minikube
$ nix-env -iA nixpkgs.kubectl
```

## minikubeの起動

```console
$ minikube start
```

## nginxのデプロイ

**provider.tf**
```hcl
provider "kubernetes" {
  config_path = "~/.kube/config"
}
```

**main.tf**
```hcl
resource "kubernetes_namespace" "example" {
  metadata {
    name = "example"
  }
}

resource "kubernetes_deployment" "nginx" {
  metadata {
    name = "nginx-deployment"
    namespace = kubernetes_namespace.example.metadata[0].name
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "nginx"
      }
    }

    template {
      metadata {
        labels = {
          app = "nginx"
        }
      }

      spec {
        container {
          image = "nginx:1.14.2"
          name  = "nginx"
        }
      }
    }
  }
}
```

**apply**
```console
$ terraform init
$ terraform apply
```

**デプロイメントの確認**
```console
$ kubectl get deployment -n example
```

**ポッドの状態確認**
```console
$ kubectl get pods -n example
```

**nginx サーバへのアクセス**
```console
$ kubectl port-forward <pod-name> 8080:80 -n example
$ curl localhost:8080
```
