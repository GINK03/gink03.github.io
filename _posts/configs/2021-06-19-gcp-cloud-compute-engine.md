---
layout: post
title: "gcp cloud compute engine"
date: 2021-06-19
excerpt: "gcp cloud compute engineについて"
tags: ["cloud compute engine", "gcp"]
config: true
comments: false
sort_key: "2021-06-19"
update_dates: ["2021-06-19","2021-06-19"]
---

# cloud compute engineについて

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

### VMをstop

```console
$ gcloud compute instances stop $VM_NAME
```

### VMをstart

```console
$ gcloud compute instances start $VM_NAME
```
