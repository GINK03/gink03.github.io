---
layout: post
title: "terraform + gcp"
date: 2024-01-30
excerpt: "terraform + gcpの基本的な使い方"
project: false
config: true
tag: ["terraform", "gcp", "google cloud platform"]
comments: false
sort_key: "2024-01-30"
update_dates: ["2024-01-30", "2026-04-17"]
---

# terraform + gcpの基本的な使い方

## 概要
 - terraformでgcpのリソースを管理
 - すでに様々なリソースがデプロイ済みであっても、terraformで管理できる
 - 各機能の説明は[Google Cloud Platform Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)を参照

## 既存の環境のexport
 - exportしたファイルは複雑で冗長な場合が多いので、そのままIaCとして使うのは難しい

**既存リソースをHCLでエクスポート**
```console
$ gcloud beta resource-config bulk-export \
  --path=./export \
  --project=YOUR_PROJECT_ID \
  --resource-format=terraform
```

**import用モジュールとスクリプト生成**
```console
$ gcloud beta resource-config terraform generate-import ./export
```

## リモートステートでの管理

**GCSバケットの作成**
```console
$ BUCKET=tfstate-$PROJECT_ID
$ gsutil mb -p $PROJECT_ID -l asia-northeast1 -b on gs://$BUCKET
```

**backend.tf**
```hcl
terraform {
  backend "gcs" {
    bucket = "tfstate-<YOUR_PROJECT_ID>"
    prefix = "envs/prod"
  }
}
```

## プロバイダの設定

**versions.tf**
```hcl
terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}
```

## 最小限のリソース別ファイル構成

```
.
├── apis.tf
├── backend.tf
├── compute.tf
├── locals.tf
├── network.tf
├── outputs.tf
├── providers.tf
├── variables.tf
└── versions.tf
```

## `prevent_destroy` による削除保護

ディスク・VPCなど削除すると復旧が困難なリソースには `lifecycle` ブロックで `prevent_destroy = true` を設定する

```hcl
resource "google_compute_disk" "data" {
  name = "my-data-disk"
  # ...

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_compute_network" "vpc" {
  name = "my-vpc"
  # ...

  lifecycle {
    prevent_destroy = true
  }
}
```

 - `terraform destroy` や `terraform apply` でリソースの削除が発生する場合にエラーで停止する
 - 設定を外さない限り削除できないため、誤操作の最後の砦になる

AIエージェントとの組み合わせでは特に重要

 - AIエージェントに `terraform apply` の権限を与える構成では、エージェントが意図せずリソース削除を含む変更を提案・実行するリスクがある
 - `prevent_destroy = true` を設定しておくと、削除を含む `plan` はapply時にエラーになるため、データロスの防止になる
 - ディスク・VPC・データベースなど、再作成コストが高いリソースには必ず設定する

