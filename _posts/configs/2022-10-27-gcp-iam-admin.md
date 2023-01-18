---
layout: post
title: "gcp security"
date: "2022-10-27"
excerpt: "gcpのsecurityで気をつけるポイント"
config: true
tag: ["gcp", "gcloud", "security"]
comments: false
sort_key: "2022-10-27"
update_dates: ["2022-10-27"]
---

# gcpのsecurityで気をつけるポイント

## 概要
 - 過剰な権限や管理されていないサービスアカウントなどが散在しているとリスクであり、管理する必要がある

## サービスアカウントとIAMの違い
 - サービスアカウント
   - GCPのプロジェクトにアクセス可能なアカウントそのもの
   - 原理的にはIAMがまったく設定されていないサービスアカウントも存在可能
     - Google Sheetsの書き込みを自動化するときなど
 - IAM
   - GCPのどのサービスにアクセスるかの許可
   - Admin系や危険が想定される権限は慎重に付与するか、動作に必要な最低限の権限に限定する

