---
layout: post
title: "terraform"
date: 2024-02-04
excerpt: "terraformの基本的な使い方"
project: false
config: true
tag: ["terraform", "gcp", "google cloud platform", "aws"]
comments: false
sort_key: "2024-02-04"
update_dates: ["2024-02-04"]
---

# terraformの基本的な使い方

## 概要
 - IaC(Infrastructure as Code)の一つ
 - AWS, GCP, Azureなどのクラウドプロバイダーに対応
 - HCL(HashiCorp Configuration Language)という独自の言語を使用
 - `terraform apply` を行うと `terraform.tfstate` というファイルが生成され、その中に現在の状態が保存される
   - `terraform.tfstate` はS3やGCSなどのリモートストレージに保存することが推奨

## インストール

**macOS**
```console
$ brew install terraform
```

**nix**
```console
$ nix profile install terraform
```

## 基本的なコマンド
 - `terraform init` - 初期化
 - `terraform plan` - 実行計画の確認
 - `terraform apply` - 実行計画の適用
 - `terraform destroy` - リソースの削除

## GitHubでの管理
 - 状態ファイルの管理
   - `.gitignore` に `terraform.tfstate` と `terraform.tfstate.backup` を追加
   - `terraform.tfstate` はリモートストレージに保存することが推奨されているため、リポジトリに保存する必要はない
 - 機密情報の管理
   - `terraform.tfvars` に機密情報を記述することは推奨されていない
   - 機密情報は環境変数やシークレットマネージャーを使用して管理することが推奨されている

## 参考
 - [Terraform を使用するためのベスト プラクティス - Google Cloud](https://cloud.google.com/docs/terraform/best-practices-for-terraform?hl=ja)
