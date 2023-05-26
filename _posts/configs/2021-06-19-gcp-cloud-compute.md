---
layout: post
title: "gcp cloud compute"
date: 2021-06-19
excerpt: "gcp cloud computeについて"
tags: ["cloud compute", "gcp"]
config: true
comments: false
sort_key: "2021-06-19"
update_dates: ["2021-06-19","2021-06-19"]
---

# cloud computeについて

## 概要
 - GCPのvm
 - sshの公開鍵を登録するにはメタデータレポジトリの[compute/metadata](https://console.cloud.google.com/compute/metadata)に設定すれば良い
   - 公開鍵のメモに記されたユーザが自動的に作成され、`~/.ssh/authorized_keys`に追記される
 - startup-scriptを設定することができる
   - root権限で実行される

## 基本的な操作

### computeインスタンスの一覧を表示

```console
$ gcloud compute instances list
```

### computeインスタンスを作成

```console
$ gcloud compute instances create <instance-name> --machine-type=<type-name>
```

**具体例**
```console
$ gcloud compute instances create test-instance --machine-type=f1-micro
```
 - 一時的に同じネットワークにインスタンスを用意したいときなど

### VMにsshアクセス

```console
$ gcloud compute ssh $VM_NAME --key-file $KEY_FILE
```

### zshrcに登録すると便利な関数

```sh
function gmosh() {
  ip=`gcloud compute instances list --filter $1 --format=json --project=starry-lattice-256603 | jq ".[0].networkInterfaces[0].accessConfigs[0].natIP"`
  mosh $ip
}
```

### startup-scriptで12時間後にシャットダウンする

```bash
#!/bin/bash
echo 'shutdown -h now' | at now + 12 hours
```

### VMをstop

```console
$ gcloud compute instances stop $VM_NAME
```

### VMをstart

```console
$ gcloud compute instances start $VM_NAME
```
