---
layout: post
title: "gcp service account impersonation"
date: 2026-05-17
excerpt: "gcpでservice account impersonationを使う方法"
config: true
tag: ["GCP", "iam", "service account", "impersonation", "gcloud"]
comments: false
sort_key: "2026-05-17"
update_dates: ["2026-05-17"]
---

## 概要
 - service account impersonationは、認証済みのユーザやサービスアカウントが、対象サービスアカウントの短期の認証情報を取得してGCP APIを呼ぶ仕組み
 - サービスアカウントキーをローカルやCIに置かずに済むため、キー漏洩のリスクを下げられる
 - AWSのAssumeRoleに近く、一時的に対象サービスアカウントとしてAPIを実行する
 - Google Cloud Consoleの画面操作ではservice account impersonationとしてアクセスできない

## 登場する権限
 - 呼び出し元
   - ユーザアカウントや別のサービスアカウント
   - 対象サービスアカウントに対して`roles/iam.serviceAccountTokenCreator`が必要
   - このロールには`iam.serviceAccounts.getAccessToken`などが含まれる
 - 対象サービスアカウント
   - 実際にGCSやBigQueryなどへアクセスする権限を持つサービスアカウント
   - たとえばGCSを読むなら対象サービスアカウントにStorage系のロールを付与する
 - API
   - Service Account Credentials APIを有効化しておく

## セットアップ

### 変数を設定する

```console
$ export PROJECT_ID="my-project"
$ export SERVICE_ACCOUNT_NAME="worker-sa"
$ export SERVICE_ACCOUNT_EMAIL="${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"
```

### Service Account Credentials APIを有効化する

```console
$ gcloud services enable iamcredentials.googleapis.com \
  --project "${PROJECT_ID}"
```

### サービスアカウントを作成する

```console
$ gcloud iam service-accounts create "${SERVICE_ACCOUNT_NAME}" \
  --project "${PROJECT_ID}" \
  --display-name "${SERVICE_ACCOUNT_NAME}"
```

### 対象サービスアカウントに実行用の権限を付与する

```console
$ gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
  --member "serviceAccount:${SERVICE_ACCOUNT_EMAIL}" \
  --role "roles/storage.objectViewer"
```

 - ここで付与するロールは、impersonateする人ではなく、対象サービスアカウントに付与する
 - `roles/editor`や`roles/owner`ではなく、実行に必要な最小権限にする

### 呼び出し元にimpersonateを許可する

```console
$ export USER_EMAIL="user@example.com"

$ gcloud iam service-accounts add-iam-policy-binding "${SERVICE_ACCOUNT_EMAIL}" \
  --project "${PROJECT_ID}" \
  --member "user:${USER_EMAIL}" \
  --role "roles/iam.serviceAccountTokenCreator"
```

 - `roles/iam.serviceAccountTokenCreator`はプロジェクトではなく、対象サービスアカウントに対して付与するのが扱いやすい
 - すべてのサービスアカウントをimpersonateできるようにプロジェクト全体へ付与すると権限が広がりやすい

## gcloudコマンドで使う

### 1コマンドだけimpersonateする

```console
$ gcloud storage buckets list \
  --project "${PROJECT_ID}" \
  --impersonate-service-account "${SERVICE_ACCOUNT_EMAIL}"
```

 - ローカルでログインしているユーザはそのままに、API呼び出しだけ対象サービスアカウントの権限で実行される
 - コマンド単位で対象を明示できるため、通常はこの使い方が確認しやすい

### gcloudのデフォルトとして設定する

```console
$ gcloud config set auth/impersonate_service_account "${SERVICE_ACCOUNT_EMAIL}"
```

 - 設定後はgcloudコマンド全体が対象サービスアカウントを使う
 - 戻すときは以下を実行する

```console
$ gcloud config unset auth/impersonate_service_account
```

## ADCでクライアントライブラリから使う

```console
$ gcloud auth application-default login \
  --impersonate-service-account "${SERVICE_ACCOUNT_EMAIL}"
```

 - `~/.config/gcloud/application_default_credentials.json`にADCの設定が作成される
 - PythonやGoなど、impersonationに対応したGoogle CloudクライアントライブラリはこのADCを使える
 - 対応していない認証ライブラリもあるため、動かない場合はサービスごとの認証ライブラリの対応状況を確認する

### Pythonで確認する

```python
import google.auth
import google.auth.transport.requests

credentials, project_id = google.auth.default(
    scopes=["https://www.googleapis.com/auth/cloud-platform"]
)

request = google.auth.transport.requests.Request()
credentials.refresh(request)

print(project_id)
print(getattr(credentials, "service_account_email", None))
```

## Terraformで使う

### ADCで使う

```console
$ gcloud auth application-default login \
  --impersonate-service-account "${SERVICE_ACCOUNT_EMAIL}"
```

 - TerraformはADCを参照できるため、ローカル開発ではこの方法で使える

### providerで明示する

```hcl
provider "google" {
  project                     = "my-project"
  region                      = "asia-northeast1"
  impersonate_service_account = "worker-sa@my-project.iam.gserviceaccount.com"
}
```

 - 環境ごとに使うサービスアカウントを変える場合はproviderに明示するほうが見通しがよい

## トークンだけ取得する

### access tokenを取得する

```console
$ gcloud auth print-access-token \
  --impersonate-service-account "${SERVICE_ACCOUNT_EMAIL}"
```

### Cloud Runなどに送るidentity tokenを取得する

```console
$ gcloud auth print-identity-token \
  --impersonate-service-account "${SERVICE_ACCOUNT_EMAIL}" \
  --audiences "https://example-xxxxx-an.a.run.app"
```

 - REST APIや一時的な検証ではトークンだけ取得して`Authorization: Bearer`ヘッダに入れる
 - ただしアプリケーション実装では、可能ならADCやクライアントライブラリに更新処理を任せる

## Service Account Userとの違い
 - `roles/iam.serviceAccountTokenCreator`
   - 短期の認証情報を作って、そのサービスアカウントとしてAPIを呼ぶためのロール
   - gcloudの`--impersonate-service-account`やADCで使う
 - `roles/iam.serviceAccountUser`
   - Cloud RunやCompute Engineなどのリソースにサービスアカウントを紐づけるためのロール
   - impersonate用のアクセストークンを作る権限ではない

## 使いどころ
 - ローカル開発で本番に近いサービスアカウント権限を使って検証する
 - CIからサービスアカウントキーなしでデプロイやバッチ実行をする
 - 一時的な昇格権限をサービスアカウント単位で管理する
 - Workload Identity Federationと組み合わせて、外部クラウドやGitHub ActionsからGCPへアクセスする

## 注意点
 - 呼び出し元の権限と対象サービスアカウントの権限は別に考える
 - 対象サービスアカウントに強いロールを付けると、impersonateできる全員がその権限を使える
 - サービスアカウントキーを作れる場合でも、まずimpersonationやWorkload Identity Federationを検討する
 - 監査ログでは、多くの場合で呼び出し元とimpersonate先の両方を確認できる

## 関連
 - [GCP ADC 認証](/gcp-adc-auth/)
 - [gcp service account](/gcp-service-account/)
 - [gcpのIAMとsecurityで気をつけるポイント](/gcp-iam-admin/)
 - [gcp workload identity federation](/gcp-workload-identity-federation/)
 - [gcp bearer token authentication](/gcp-bearer-token-authentication/)

## 参考
 - [Use service account impersonation](https://cloud.google.com/docs/authentication/use-service-account-impersonation)
 - [Service account impersonation](https://cloud.google.com/iam/docs/service-account-impersonation)
 - [Authentication for Terraform](https://cloud.google.com/docs/terraform/authentication)
 - [gcloud auth print-identity-token](https://cloud.google.com/sdk/gcloud/reference/auth/print-identity-token)
