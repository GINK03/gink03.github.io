---
layout: post
title: "gcp cloud scheduler"
date: 2023-12-30
excerpt: "gcp cloud schedulerの概要"
tags: ["gcp", "cloud scheduler"]
config: true
comments: false
sort_key: "2023-12-30"
update_dates: ["2023-12-30"]
---

# gcp cloud schedulerの概要

## 概要
 - gcpのサービス間で定期的に処理を実行するためのサービス
 - [/uxni cron/](/unix-cron/)のような機能を提供する
 - 以下のサービスと連携できる
   - Pub/Sub
   - App Engine
   - HTTPエンドポイント
     - Cloud Functions
     - Cloud Run

## コマンド例

### Cloud Runを定期実行する
 - 外部からのアクセスを禁止したCloud Runに対して、サービスアカウントを設定して、Cloud Schedulerから定期実行する

```console
$ gcloud beta scheduler jobs create http \
  [JOB_NAME] \
  --schedule="0 9 * * *" \
  --uri="https://cron-job-xxxxxx-uc.a.run.app" \
  --http-method=GET \
  --time-zone="Asia/Tokyo" \
  --oidc-service-account-email=[YOUR_SERVICE_ACCOUNT_EMAIL]
```

## 参考
 - [cron ジョブのスケジュールを設定して実行する | Google Cloud](https://cloud.google.com/scheduler/docs/schedule-run-cron-job?hl=ja)
