---
layout: post
title: "cloud run jobs"
date: 2024-12-05
excerpt: "cloud run jobsついて"
tags: ["gcp", "cloud run", "cloud run jobs"]
config: true
comments: false
sort_key: "2024-12-05"
update_dates: ["2024-12-05"]
---

# cloud run jobsについて

## 概要
 - cloud run jobsは、cloud runの新機能で、バッチ処理やcronジョブを実行するための機能
 - httpのエンドポイントを持たず、実行できる
 - 最大24時間までの実行時間を持つ

## 使い方

### ジョブの作成

```console
$ gcloud beta run jobs create my-job \
  --image asia-northeast1-docker.pkg.dev/my-project/my-repo/my-image:latest \
  --region asia-northeast1 \
  --cpu 2 \
  --memory 2Gi \
  --max-retries 3 \
  --set-env-vars "ENV1=value1,ENV2=value2" \
  --task-timeout 3600
```

### ジョブの実行

```console
$ gcloud beta run jobs execute my-job --region asia-northeast1
```

### ジョブの確認

```console
$ gcloud beta run jobs executions list --region asia-northeast1
```

### スケジュール実行

```console
$ gcloud scheduler jobs create http my-scheduler-job \
  --schedule "0 3 * * *" \
  --uri https://asia-northeast1-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/[PROJECT_ID]/jobs/my-job:run \
  --http-method POST \
  --oauth-service-account-email [SERVICE_ACCOUNT]
```
 
 - `[SERVICE_ACCOUNT]`はcloud run jobsのサービスアカウントを指定する
