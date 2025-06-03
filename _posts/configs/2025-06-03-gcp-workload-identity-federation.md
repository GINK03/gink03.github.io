---
layout: post
title: "gcp workload identity federation" 
date: 2025-06-03
excerpt: "gcp workload identity federation"
tags: ["gcp", "workload identity federation", "gcp workload identity federation"]
config: true
comments: false
sort_key: "2025-06-03"
update_dates: ["2025-06-03"]
---

# gcp workload identity federation

## 概要
 - 直接 GCP のサービスアカウントを使用するのではなく、外部 ID プロバイダを使用して GCP リソースにアクセスするための方法
 - workload identity federation (WIF) の特徴
   - 鍵ファイルゼロ
   - 自動ローテーション: おおよそ1時間ごとに自動で更新される

## シナリオ別使い方

### AWS EC2 インスタンスから GCP リソースにアクセスする

**挙動のイメージ**
 - EC2（IAM ロール） ↔ WIF（STS） ↔ SA impersonation ↔ GCP リソース

**GCP 側セットアップ**
```console
# 作成
$ gcloud iam service-accounts create ci-sa \
  --description="AWS EC2 via WIF" \
  --display-name="ci-sa"

# Secret Manager 読み取り権限
$ gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member="serviceAccount:ci-sa@$PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/secretmanager.secretAccessor"

# Workload Identity Pool & Provider
## pool 作成
$ gcloud iam workload-identity-pools create aws-pool \
  --location="global" \
  --display-name="AWS EC2 Pool"

## provider 作成
$ gcloud iam workload-identity-pools providers create-aws aws-provider \
  --location="global" \
  --workload-identity-pool="aws-pool" \
  --account-id="$AWS_ACCOUNT_ID"

# AWS 身元 → SA へのバインディング
$ gcloud iam service-accounts add-iam-policy-binding \
  ci-sa@$PROJECT_ID.iam.gserviceaccount.com \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/aws-pool/attribute.aws_role/arn:aws:iam::$AWS_ACCOUNT_ID:role/gcp-wif-role"

# 外部アカウント資格情報ファイルを生成
$ gcloud iam workload-identity-pools create-cred-config \
  projects/$PROJECT_NUMBER/locations/global/workloadIdentityPools/aws-pool/providers/aws-provider \
  --service-account=ci-sa@$PROJECT_ID.iam.gserviceaccount.com \
  --output-file=aws-wif-creds.json
```

**AWS 側セットアップ**
 - `sts:GetCallerIdentity` の許可が必要
 - `export GOOGLE_APPLICATION_CREDENTIALS=/etc/gcp/aws-wif-creds.json` で環境変数を設定


