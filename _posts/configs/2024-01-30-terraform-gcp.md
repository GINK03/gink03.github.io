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
update_dates: ["2024-01-30"]
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
# backend.tf
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
      version = "~> 6.0"   # 6.x 系に固定（お好みで >=6,<8 でもOK）
    }
  }
}
```

## 最小限のリソース別ファイル構成

```console
$ tree .
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

