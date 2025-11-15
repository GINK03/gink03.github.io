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
update_dates: ["2024-02-04", "2025-08-27"]
---

# terraformの基本的な使い方

## 概要
 - IaC (Infrastructure as Code) の一つ
 - AWS, GCP, Azureなどのクラウドプロバイダーに対応
 - HCL (HashiCorp Configuration Language) という独自の言語を使用
 - `terraform apply` を行うと `terraform.tfstate` というファイルが生成され、その中に現在の状態が保存される
   - `terraform.tfstate` はS3やGCSなどのリモートストレージに保存することが推奨であり、チームで状態を共有できる

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

**Ubuntu**
```console
$ git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv
$ echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.zshrc
$ source ~/.zshrc
$ tfenv install latest
$ tfenv use latest
$ terraform -v
```

## 基本的なコマンド
 - `terraform init` - 初期化
 - `terraform plan` - 実行計画の確認
 - `terraform apply` - 実行計画の適用
 - `terraform destroy` - リソースの削除

## gitでの管理
 - 状態ファイルの管理
   - `.gitignore` に `terraform.tfstate` と `terraform.tfstate.backup` を追加
   - `.gitignore` に `.terraform/` も追加（プラグインやキャッシュのディレクトリ）
   - `terraform.tfstate` はリモートストレージに保存することが推奨されているため、リポジトリに保存する必要はない
   - 依存プロバイダの固定用 `./.terraform.lock.hcl` は再現性のためコミットする
 - 機密情報の管理
   - 機密情報を含む `.tfvars` をリポジトリにコミットしない（`.gitignore` に追記）
   - 代替として、環境変数 `TF_VAR_foo=...` を使う、あるいは各クラウドのシークレットマネージャーを使用
   - 変数定義は `variable "foo" { sensitive = true }` を用いて出力に漏れないようにする

## gitでcommit前のチェック

**formatの静的チェック**
```console
$ terraform fmt -recursive
$ terraform validate
```

## よくある構成

```console
repo/
  envs/
    dev/
      main.tf
      providers.tf
      variables.tf     # env固有の値（project_id, region, zone など）
      backend.tf
      versions.tf
      terraform.tfvars # 任意: project_id 等をここに
  modules/
    network/
      main.tf
      variables.tf
      outputs.tf
    vm/
      main.tf
      variables.tf
      outputs.tf
```

## 参考
 - [Terraform を使用するためのベスト プラクティス - Google Cloud](https://cloud.google.com/docs/terraform/best-practices-for-terraform?hl=ja)
