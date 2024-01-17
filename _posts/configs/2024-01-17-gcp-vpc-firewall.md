---
layout: post
title: "gcp vpc firewall"
date: 2024-01-17
excerpt: "gcp vpc firewallの概要"
tags: ["gcp", "vpc firewall", "firewall"]
config: true
comments: false
sort_key: "2024-01-17"
update_dates: ["2024-01-17"]
---

# gcp vpc firewallの概要

## 概要
 - GCPのVPC内での通信を制御するための機能
 - Compute Engineのインスタンスに対して適用することができる
 - デフォルトでは、上りはssh, rdpとicmpの通信が許可されている
 - 下りはすべての通信が許可されている
 - ルールは優先順位を持っており、数字が小さいほど優先度が高い

## gcloudコマンドでの操作

**ルールの作成**
```console
$ gcloud compute firewall-rules create [RULE_NAME] \
  --direction=INGRESS \
  --priority=1000 \
  --network=[NETWORK_NAME] \
  --action=ALLOW \
  --rules=tcp:80 \
  --source-ranges=[IP_RANGES]
```

 - `[RULE_NAME]` : ルール名
 - `[NETWORK_NAME]` : ネットワーク名
 - `[IP_RANGES]` : 許可するIPアドレスの範囲(例: 0.0.0.0/0)

**ルールの更新**
```console
$ gcloud compute firewall-rules update [RULE_NAME] \
  --direction=INGRESS \
  --priority=1000 \
  --network=[NETWORK_NAME] \
  --action=ALLOW \
  --rules=tcp:80 \
  --source-ranges=[IP_RANGES]
```

**ルールの削除**
```console
$ gcloud compute firewall-rules delete [RULE_NAME]
```
