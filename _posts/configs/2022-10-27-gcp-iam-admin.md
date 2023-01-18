---
layout: post
title: "gcp iam-admin"
date: "2022-10-27"
excerpt: "gcpのIAMとsecurityで気をつけるポイント"
config: true
tag: ["gcp", "gcloud", "security", "iam"]
comments: false
sort_key: "2022-10-27"
update_dates: ["2022-10-27"]
---

# gcpのIAMとsecurityで気をつけるポイント

## 概要
 - 過剰な権限や管理されていないサービスアカウントなどが散在しているとリスクであり、管理する必要がある

## サービスアカウントとIAMの違い
 - サービスアカウント
   - GCPのプロジェクトにアクセス可能なアカウントそのもの
   - 原理的にはIAMがまったく設定されていないサービスアカウントも存在可能
     - Google Sheetsの書き込みを自動化するときなど
 - IAM
   - GCPのどのサービスの使用を許可するかを設定できる
   - Admin系や危険が想定される権限は慎重に付与するか、動作に必要な最低限の権限に限定する

---

## 参考
 - [console.cloud.google.com/iam-admin/](https://console.cloud.google.com/iam-admin/iam)
