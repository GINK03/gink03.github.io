---
layout: post
title: "cloud compute engine"
date: 2021-06-19
excerpt: "cloud compute engineについて"
tags: ["cloud compute engine", "gcp"]
config: true
comments: false
---

# cloud compute engineについて

### 一覧を表示

```console
$ gcloud compute instances list
```

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
