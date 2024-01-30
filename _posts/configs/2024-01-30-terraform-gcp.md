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
 - 各機能の説明は[Google Cloud Platform Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)を参照

## 具体例
 - Cloud Storageのバケットを作成する
 - Cloud Runのサービスを作成する
 - Cloud SchedulerのジョブでCloud Runのサービスを定期実行する

```hcl
provider "google" {
  project     = "starry-lattice-256603"
  region      = "us-central1"  # 任意のリージョン
}

# GCSバケットの作成の例
resource "google_storage_bucket" "my_bucket" {
  name     = "my-bucket-name-tf"
  location = "US"
}

output "bucket_name" {
  value = google_storage_bucket.my_bucket.name
}

# Cloud Runのサービスの作成の例
resource "google_cloud_run_v2_service" "hello_service" {
  name     = "hello-service"
  location = "us-central1"
  ingress = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "us-docker.pkg.dev/cloudrun/container/hello"
      resources {
        limits = {
          cpu    = "2"
          memory = "1024Mi"
        }
      }
    }
  }
}

# Cloud RunのサービスのIAMポリシーの設定の例(認証なし)
data "google_iam_policy" "noauth" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_v2_service.hello_service.location
  project  = google_cloud_run_v2_service.hello_service.project
  service  = google_cloud_run_v2_service.hello_service.name
  policy_data = data.google_iam_policy.noauth.policy_data
}

# Cloud Runのデプロイ時のURLの取得の例
data "google_cloud_run_service" "hello_service" {
  location = google_cloud_run_v2_service.hello_service.location
  project  = google_cloud_run_v2_service.hello_service.project
  name = google_cloud_run_v2_service.hello_service.name
}

output "hello_service_url" {
  value = data.google_cloud_run_service.hello_service.status[0].url
}

# Cloud Schedulerのジョブの作成の例(1分ごとにCloud Runのサービスを叩く)
resource "google_cloud_scheduler_job" "hello_job" {
    name     = "hello-job"
    schedule = "*/1 * * * *"
    time_zone = "Asia/Tokyo"
    description = "Hello Job"
    http_target {
        uri = data.google_cloud_run_service.hello_service.status[0].url
        http_method = "GET"
    }
}
```
