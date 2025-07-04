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
# brew では最新のバージョンがインストールされないため、tfenvを使用することを推奨
$ brew uninstall terraform
$ brew install tfenv
$ tfenv install latest
$ tfenv use latest
$ terraform -v
```

**ubuntu**
```console
# 1. HashiCorp GPGキーを登録
$ curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -

# 2. リポジトリを追加（Ubuntu のコードネームは自動取得）
$ sudo apt-add-repository \
   "deb [arch=amd64] https://apt.releases.hashicorp.com \
   $(lsb_release -cs) main"

# 3. パッケージリストを更新して Terraform をインストール
$ sudo apt-get update && sudo apt-get install -y terraform
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

## gitでの管理
 - 状態ファイルの管理
   - `.gitignore` に `terraform.tfstate` と `terraform.tfstate.backup` を追加
   - `terraform.tfstate` はリモートストレージに保存することが推奨されているため、リポジトリに保存する必要はない
 - 機密情報の管理
   - `terraform.tfvars` に機密情報を記述することは推奨されていない
   - 機密情報は環境変数やシークレットマネージャーを使用して管理することが推奨されている

## gitでcommit前のチェック

**formatの静的チェック**
```console
$ terraform fmt -recursive
$ terraform validate
```

## 参考
 - [Terraform を使用するためのベスト プラクティス - Google Cloud](https://cloud.google.com/docs/terraform/best-practices-for-terraform?hl=ja)
